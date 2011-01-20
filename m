From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Wed, 19 Jan 2011 18:38:14 -0800
Subject: [PATCH 2/2] serial: msm: Add support for UARTDM cores
In-Reply-To: <20110119222407.GD6335@n2100.arm.linux.org.uk>
References: <1295407585-18386-1-git-send-email-stepanm@codeaurora.org>
	<20110119082534.GA9569@gallagher> <4D3760DD.1010609@codeaurora.org>
	<20110119222407.GD6335@n2100.arm.linux.org.uk>
Message-ID: <4D37A016.8060902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/19/2011 2:24 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 19, 2011 at 02:08:29PM -0800, Stepan Moskovchenko wrote:
>>>> +		/* Mask conditions we're ignorning. */
>>>> +		sr&= port->read_status_mask;
>>>> +		if (sr&   UART_SR_RX_BREAK)
>>>> +			flag = TTY_BREAK;
>>>> +		else if (sr&   UART_SR_PAR_FRAME_ERR)
>>>> +			flag = TTY_FRAME;
>>> It doesn't look like the flag is used anywhere after it has been
>>> assigned.
>> An artifact of an old driver. Removed.
> But still required to support proper error signalling.
>

On second thought, from poking around the kernel some more, I believe 
the following should be a better approach:
         if (sr & UART_SR_RX_BREAK) {
             tty_insert_flip_char(tty, 0, TTY_BREAK);
         } else if (sr & UART_SR_PAR_FRAME_ERR) {
             tty_insert_flip_char(tty, 0, TTY_FRAME);
         }

Russell, what do you think? Shall I make the change in v2?

Thanks
Steve

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
