From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 17 Oct 2013 23:52:15 +0400
Subject: =?UTF-8?B?UmU6IGlteC1kcm06IEFkZCBIRE1JIHN1cHBvcnQ=?=
In-Reply-To: <20131017193948.GT25034@n2100.arm.linux.org.uk>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
Message-ID: <1382039535.976669051@f130.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Little bit late to the party, but here is the patch for the latest  
> > version of the HDMI driver I was working on. Having had a quick flick  
> > through the mailing list I see Russell has noticed a few of the problems  
> > I had earlier on, which are resolved in my later work. Thought this  
> > might be useful to help you tidy things up.
...
> Now, I notice that the FSL 4.1.0 stuff appears to try and decide
> which of the two clock inputs to use for the DI module, something
> which isn't done in the driver in staging.  Also there's the commented
> out stuff:
> 
> #ifdef WTF_IS_THIS
>         /*
>          * Freescale has this in their Kernel. It is neither clear what
>          * it does nor why it does it
>          */
>         if (div & 0x10)
>                 div &= ~0x7;
>         else {
>                 /* Round up divider if it gets us closer to desired pix clk */
>                 if ((div & 0xC) == 0xC) {
>                         div += 0x10;
>                         div &= ~0xF;
>                 }
>         }
> #endif
> 
> Quite simply, the "div" value is as follows:
> 
> bits 11:4 - integer divider
> bits  3:0 - fractional part
> 
> So, what this is saying is that for any _odd_ integer divider, we want
> to either divide by the odd divider, or odd.5 - but no other fractional
> values.  Otherwise, if the divider is an even integer divider, and the
> fractional part is greater than .75, we want to round that up.  (It may
> also be that the final div & ~0xf should be outside that second if
> statement.)
> 
> It could be that the fractional divider is broken and doesn't work
> correctly with the values that this is trying to avoid.

This problem has been described by me, but solution hung in the air:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/176424.html

---
