From: alan@linux.intel.com (Alan Cox)
Date: Tue, 10 May 2011 10:32:56 +0100
Subject: BUG: sleeping function called from invalid context
In-Reply-To: <4DC8CF50.4040003@st.com>
References: <4DC8CF50.4040003@st.com>
Message-ID: <20110510103256.58d61861@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On analysis, I found that this is due to the change introduced in 
> tty_ioctl.c where the termios mutex is taken to protect against
> parallel throttle/unthrottle. Probably IrCOMM stack code wasn't
> tested before merging this patch.
> 
> Please suggest what should be done with the IrCOMM protocol stack
> code to resolve this problem?

It looks like the comments are wrong 

        /*
         * Just give it over to the line discipline. There is no need to
         * involve the flip buffers, since we are not running in an
        interrupt
         * handler
         */


appears to be completely untrue

I suspect it just needs to use the tty_flip_buffer functions properly
instead of trying to do clever shortcuts


	tty_insert_flip_string(self->tty, skb->data, skb->len);
	tty_flip_buffer_push(self->tty);
