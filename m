From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 27 Mar 2012 10:54:33 -0700
Subject: [PATCH] atmel-serial: fix RS485 half-duplex problem
In-Reply-To: <6FF0F449D45DEE479E93D93A0C07A8BD025E8F0631@USROCEX01>
References: <6FF0F449D45DEE479E93D93A0C07A8BD025E8F0631@USROCEX01>
Message-ID: <20120327175433.GA6623@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 01:43:39PM -0400, Siftar, Gabe wrote:
> On our custom board, we are using RS485 in half-duplex mode on an AT91SAM9G45. 
> SER_RS485_RX_DURING_TX is not set as we do not want to receive the data we 
> transmit (our transceiver will receive transmitted data).  Although the current 
> driver attempts to disable and enable the receiver at the appropriate points, 
> incoming data is still loaded into the receive register causing our code to 
> receive the very last byte that was sent once the receiver is enabled.
>  
> I ran this by Atmel support and they wrote:  "The issue comes from the fact 
> that you disable the PDC/DMA Reception and not the USART Reception channel.  In 
> your case, the[n] you will still receive data into the USART_RHR register, and 
> maybe you [h]ave the overun flag set.  So please disable the USART reception 
> channel."
>   
> The following patch should force the driver to enable/disable the receiver via 
> RXEN/RXDIS fields of the USART control register.  It fixed the issue I was 
> having - perhaps others will find it useful as well.
> 
> Signed-off-by: Gabe Siftar <gabe.siftar@getingeusa.com>

That's nice, but:

> This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to which they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately by e-mail if you have received this e-mail by mistake and delete this e-mail from your system. If you are not the intended recipient you are notified that disclosing, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited.--

This footer just contridicted your signed-off-by:

So, what should I believe?

Hint, please remove such footers, and tell anyone who insists on them
that they directly prevent you from contributing to the kernel, as I can
not accept patches with this on it.

Care to resend this without the footer so I can accept it?

greg k-h
