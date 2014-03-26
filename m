From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 26 Mar 2014 22:52:27 +0100
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140326214259.GA12330@obsidianresearch.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
Message-ID: <20140326225227.4630e947@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 26 Mar 2014 15:42:59 -0600, Jason Gunthorpe wrote:
> On Wed, Mar 26, 2014 at 08:34:19PM +0000, Neil Greatorex wrote:
> > Thanks. Here's the relevant output with that patch:
> > 
> > [    0.135772] mvebu-pcie pcie-controller.3: ICR is 0
> > [    0.160889] mvebu-pcie pcie-controller.3: Vendor ID is ffffffff
> > [    0.160897] mvebu-pcie pcie-controller.3: ICR is 800200
> > [    1.170215] mvebu-pcie pcie-controller.3: Try 2: Vendor ID is 15218086
> > [    1.170228] mvebu-pcie pcie-controller.3: ICR is 0
> 
> Okay, this looks better..
> 
> Thomas: Can you verify the decoding of the ICR register (offset
> 0x1900)?
> 
> My Kirkwood manual says 0x800200 is 'Non-Fatal Error Detected' and 'Link
> Failure Indication' - the latter seems very strange.

Decoding is:

 bit 0, TxReqInDIdownErr
 bit 1, MDis
 bit 2, reserved
 bit 3, ErrWrToReg
 bit 4, HitDfltWinErr
 bit 5, reserved
 bit 6, RxRamParErr
 bit 7, TxRamParErr
 bit 8, CorErrDet
 bit 9, NFErrDet
 bit 10, FErrDet
 bit 11, DstateChange
 bit 12, BIST
 bit 13, reserved
 bit 14, FlowCtrlProtocol
 bit 15, RcvUrCaErr
 bit 16, RcvErrFatal
 bit 17, RcvErrNonFatal
 bit 18, RcvErrCor
 bit 19, RcvCRS
 bit 20, PexSlvHotReset
 bit 21, PexSlvDisLink
 bit 22, PexSlvLb
 bit 23, PexLinkFail
 bit 24, RcvIntA
 bit 25, RcvIntB
 bit 26, RcvIntC
 bit 27, RcvIntD
 bit 28, RcvPmPme
 bit 29, RcvTurnOff
 bit 30, reserved
 bit 31, RcvMsi

So 800200 = bit 23 and bit 9, which means:

 * bit 9, NFErrDet, Non fatal error detected
 * bit 23, PexLinkFail

So it's the same as Kirkwood, at least for these bits. 

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
