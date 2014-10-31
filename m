From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Oct 2014 23:41:30 -0700
Subject: [PATCH 2/2] tty: serial: msm: Support sysrq on uartDM devices
In-Reply-To: <54522163.8030408@linaro.org>
References: <1414606478-13709-1-git-send-email-sboyd@codeaurora.org>
 <1414606478-13709-3-git-send-email-sboyd@codeaurora.org>
 <54522163.8030408@linaro.org>
Message-ID: <20141031064130.GG12469@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30, Daniel Thompson wrote:
> On 29/10/14 18:14, Stephen Boyd wrote:
> > +		r_count = min_t(int, count, sizeof(buf));
> > +
> > +		for (i = 0; i < r_count; i++) {
> > +			char flag = TTY_NORMAL;
> >  
> > -		/* TODO: handle sysrq */
> > -		tty_insert_flip_string(tport, buf, min(count, 4));
> > -		count -= 4;
> > +			if (msm_port->break_detected && buf[i] == 0) {
> > +				port->icount.brk++;
> > +				flag = TTY_BREAK;
> > +				msm_port->break_detected = false;
> > +				if (uart_handle_break(port))
> > +					continue;
> > +			}
> > +
> > +			if (!(port->read_status_mask & UART_SR_RX_BREAK))
> > +				flag = TTY_NORMAL;
> 
> flag is already known to be TTY_NORMAL.

Huh? If we detected a break we would set the flag to TTY_BREAK
and if uart_handle_break() returned 0 (perhaps sysrq config is
diasbled) then we would get down here, and then we want to reset
the flag to TTY_NORMAL if the read_status_mask bits indicate that
we want to skip checking for breaks. Otherwise we want to
indicate to the tty layer that it's a break character.

> 
> 
> > +
> > +			spin_unlock(&port->lock);
> 
> Is it safe to unlock at this point? count may no longer be valid when we
> return.

Can you explain further? If it actually isn't valid something
needs to be done. I believe other serial drivers are doing this
sort of thing though so it doesn't seem that uncommon (of course
those drivers could also be broken I suppose).

> 
> 
> > +			sysrq = uart_handle_sysrq_char(port, buf[i]);
> > +			spin_lock(&port->lock);
> > +			if (!sysrq)
> > +				tty_insert_flip_char(tport, buf[i], flag);
> 
> flag has a constant value here.
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
