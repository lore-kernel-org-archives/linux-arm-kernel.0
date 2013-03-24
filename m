From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 24 Mar 2013 15:26:59 +0100
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <201303062013.16302@pali>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
 <20130306175120.GP11806@atomide.com> <201303062013.16302@pali>
Message-ID: <201303241526.59275@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 March 2013 20:13:15 Pali Roh?r wrote:
> On Wednesday 06 March 2013 18:51:21 Tony Lindgren wrote:
> > * Pali Roh?r <pali.rohar@gmail.com> [130306 06:13]:
> > > On Monday 04 March 2013 19:58:06 Tony Lindgren wrote:
> > > > * Nishanth Menon <nm@ti.com> [130301 06:42]:
> > > > > On Fri, Mar 1, 2013 at 1:47 AM, ?????? ????????
> > > 
> > > <freemangordon@abv.bg> wrote:
> > > > > > They look similar, but they are not equivalent :).
> > > > > > The first major difference is here (code taken from
> > > > > > omap-smc.S)
> > > > > > 
> > > > > >> ENTRY(omap_smc2)
> > > > > >> 
> > > > > >>          stmfd   sp!, {r4-r12, lr}
> > > > > >>          mov     r3, r2
> > > > > >>          mov     r2, r1
> > > > > >>          mov     r1, #0x0        @ Process ID
> > > > > >>          mov     r6, #0xff
> > > > > >>          mov     r12, #0x00      @ Secure Service
> > > > > >>          ID
> > > > > > 
> > > > > > Always zero, while RX51 PPA expects a real value. I
> > > > > > wonder if it is a bug, but anyway I don't see the id
> > > > > > parameter (R0) used.
> > > > > > 
> > > > > >>          mov     r7, #0
> > > > > >>          mcr     p15, 0, r7, c7, c5, 6
> > > > > > 
> > > > > > According to ARM TRM, this is "Invalidate entire
> > > > > > branch predictor array"(IIUC). NFC why it is needed
> > > > > > here, but this will not work on RX-51 until IBE bit
> > > > > > in ACR is set.
> > > > > > 
> > > > > >>          dsb
> > > > > >>          dmb
> > > > > >>          smc     #0
> > > > > > 
> > > > > > RX-51 needs smc #1 ;)
> > > > > > 
> > > > > >>          ldmfd   sp!, {r4-r12, pc}
> > > > > > 
> > > > > > The next major difference is that RX-51 expects
> > > > > > parameter count passed in R3[0] to be the count of
> > > > > > the remaining parameters +1, but
> > > > > > omap_secure_dispatcher (in omap-secure.c) is passing
> > > > > > the exact count of the remaining parameters.
> > > > > > 
> > > > > > I guess all of the above problems can be
> > > > > > fixed/workarounded, but I wonder does it worth. Not
> > > > > > to say that I don't have BB around to test if the
> > > > > > code still works if I make changes to
> > > > > > omap2-secure.c/omap-smc.S :)
> > > > > 
> > > > > Yep, that was my point - instead of introducing new
> > > > > functions, extending the existing functions to handle
> > > > > new requirements is better solution, IMHO.
> > > > 
> > > > I think there have been patches posted for ARM generic
> > > > SMC handling. Might be worth looking at those a bit and
> > > > see if this can be made generic. I think only the SMC
> > > > call numbering is different for various SoCs?
> > > > 
> > > > Regards,
> > > > 
> > > > Tony
> > > 
> > > Hi Tony, where are patches for ARM generic SMC handling?
> > 
> > Sorry don't have the link available, but I recall seeing
> > some patch on linux-arm-kernel within past six months that
> > added a generic smc function.. Or maybe I was dreaming or
> > something.
> > 
> > Regards,
> > 
> > Tony
> 
> I am not able to find that patch...

Hi Tony,

it is possible to upstream errata 430973 workaround for RX-51?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130324/a554eddb/attachment.sig>
