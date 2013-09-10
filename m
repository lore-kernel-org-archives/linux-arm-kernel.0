From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Sep 2013 10:05:41 +0100
Subject: [RFC] ARM: kernel: io: Optimize memcpy_fromio function.
In-Reply-To: <522DFB81.20203@gmail.com>
References: <1378743604-7339-1-git-send-email-b45784@freescale.com>
 <522DFB81.20203@gmail.com>
Message-ID: <20130910090541.GF5426@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 05:46:57PM +0100, Dirk Behme wrote:
> Am 09.09.2013 18:20, schrieb Pardeep Kumar Singla:
> > Currently memcpy_fromio function is copying byte by byte data.
> > By replacing this function with inline assembly code, it is copying now 32 bytes at one time.
> > By running two test cases(Tested on mx6qsabresd board),results are following :-
> >
> > a)First test case  by calling the memcpy_fromio function only once:-
> > 	1. With Optimization it is just taking 6 usec.
> > 	2. Without optimization it is taking 114usec.
> > b)Second test case by calling the memcpy_fromio function 100000 times.
> > 	1.With Optimization it is just taking .8 sec
> > 	2.Without optimization it is taking 11 sec.
> >
> > Signed-off-by: Pardeep Kumar Singla <b45784@freescale.com>
> 
> Is there any special reason trying to optimize memcpy_fromio() itself? 
> Instead of using anything like
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173195.html
> 
> ? I.e. using already existing optimized code?

Well, accessing device memory has additional restrictions over normal memory
(e.g. no unaligned access) and you may also not want to use
load/store-multiple if the device can't deal with repeated access to the
same location.

I think it's better to treat I/O separately to normal ram.

Will
