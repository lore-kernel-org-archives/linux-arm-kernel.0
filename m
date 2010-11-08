From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 08 Nov 2010 10:11:50 -0800
Subject: [PATCHv2 2/3] ARM: Allow machines to override __delay()
In-Reply-To: <4CD4CD21.8080801@codeaurora.org>
References: <1288300770-18350-1-git-send-email-sboyd@codeaurora.org>
	<1288300770-18350-3-git-send-email-sboyd@codeaurora.org>
	<1288899002.21823.3.camel@c-dwalke-linux.qualcomm.com>
	<4CD31E67.60107@codeaurora.org>
	<1288905414.21823.12.camel@c-dwalke-linux.qualcomm.com>
	<4CD47C6E.3050702@codeaurora.org> <1289000592.15381.23.camel@m0nster>
	<4CD4CD21.8080801@codeaurora.org>
Message-ID: <1289239910.6024.12.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-05 at 20:36 -0700, Stephen Boyd wrote:
> On 11/05/2010 04:43 PM, Daniel Walker wrote:
> > On Fri, 2010-11-05 at 14:51 -0700, Stephen Boyd wrote:
> >> Ok. Doing that increases the size of my vmlinux.
> >>
> >> $ size vmlinux.orig vmlinux.new
> >>    text    data     bss     dec     hex filename
> >> 7091426  594512 1244648 8930586  88451a vmlinux.orig
> >> 7091514  594512 1244648 8930674  884572 vmlinux.new
> >
> > This is what I get,
> >
> >    text    data     bss     dec     hex filename
> > 2168427  104288  186176 2458891  25850b ../build-test/vmlinux.orig
> > 2168379  104288  186176 2458843  2584db ../build-test/vmlinux.new
> >
> > Your patch has something wrong with it, which I fixed. Details below,
> >
> [snip]
> >> - */
> >> -void __delay(unsigned long loops)
> >> -{
> >> -	delay_fn(loops);
> >> -}
> >>  EXPORT_SYMBOL(__delay);
> >
> > You need to modify this EXPORT_SYMBOL to delay_fn since __delay doesn't
> > exist anymore.
> 
> Wait. Doesn't this mean we're exporting delay_fn instead of __delay now?
> i.e. the symbol name has changed and modules can no longer call __delay?
> That sounds bad.

The modules would just call the new symbol. It would be a problem for
binary modules, but we don't really cater to binary modules. Like you
suggest below you could change the name to __delay().

> If I make that change, my kernel size is exactly the same before and
> after. It may sound like a win since you got a decrease and I got a net
> zero, but I'm not sure since the symbol has changed. I could make

I can't imagine how it's a net zero change for you. The change is
removing two global functions.

> __delay a function pointer and assign it directly but I'm not very
> interested to expose a function pointer to modules allowing them to
> modify it at any time (easily). Actually, I should probably mark
> set_delay_fn __init so it gets thrown away after init when its far too
> late to switch the delay function anyway. That would give you the space
> savings you want and allow me to keep the delay_fn static to delay.c

I don't think we need to protect other code authors to that degree. You
could put down a comment letting people know it's bad to alter __delay
after bootup .. I doubt this API will be used all that often..

Marking it __init only saves run time space it doesn't reduce the image
size. However, since set_delay_fn is likely to be used in __init
sections already, and it's inline, means the code is likely to get
removed in that case too. So doing it the way I'm suggesting give you a
smaller image size, and smaller runtime size.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
