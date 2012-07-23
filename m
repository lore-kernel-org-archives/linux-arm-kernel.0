From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Jul 2012 19:12:49 +0100
Subject: Help request - ASoC recursion issue
In-Reply-To: <500D6602.6070809@linaro.org>
References: <500D5A1F.9000808@linaro.org> <500D649B.80704@linaro.org>
 <500D6602.6070809@linaro.org>
Message-ID: <20120723181249.GF3421@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 03:56:02PM +0100, Lee Jones wrote:
> On 23/07/12 15:50, Lee Jones wrote:
> >> I was wondering if I may bother you for some help. I've been having
> >> serious issues with testing the new mop500 sound system you have in your
> >> ASoC for-next branch. I've fixed a few issues and will be submitting
> >> patches shortly. The most serious issue I came across was with
> >> recursion.
> >
> > It appears you can ignore this. I just tried another piece of hardware
> > and this problem doesn't arise, leading me to believe I have some kind
> > of eMMC corruption error going on with one of my boards.
> 
> FYI, just so you don't think I'm mad: http://paste.ubuntu.com/1106535/

I still maintain that you're getting memory corruption as a result of your
linear mapping getting screwed up:

  Truncating RAM at 18000000-3fffffff to -2c3fffff (vmalloc region overlap).

looks wrong to me. Your command line also has some non-standard mem= options
that I don't understand:

  vmalloc=300M mem=128M at 0 mali.mali_mem=64M at 128M hwmem=168M at 192M mem=22M at 360M mem_issw=1M at 383M mem=640M at 384M

I'd guess you need highmem to map that lot, but you don't appear to have that
enabled and you end up with a rather strange amount of reported memory to go
with your lowmem mapping:

  Memory: 474156k/474156k available, 11220k reserved, 0K highmem
  Virtual kernel memory layout:
      vector  : 0xffff0000 - 0xffff1000   (   4 kB)
      fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
      vmalloc : 0xec800000 - 0xff000000   ( 296 MB)
      lowmem  : 0xc0000000 - 0xec400000   ( 708 MB)

Now, I don't know a thing about Snowball, so maybe this is all normal for
that board but if you're seeing memory corruption I'd get to the bottom of
this before trying to debug instances of it cropping up in random driver
code :)

Will
