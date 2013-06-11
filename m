From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 11 Jun 2013 10:57:38 -0300
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130609014506.GB10027@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072101.44694.arnd@arndb.de>
 <20130607200054.GA9010@obsidianresearch.com>
 <20130608183851.GB2354@localhost>
 <20130609014506.GB10027@obsidianresearch.com>
Message-ID: <20130611135737.GC3996@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Arnd:

On Sat, Jun 08, 2013 at 07:45:06PM -0600, Jason Gunthorpe wrote:
[...]
> 
> This is the mangling I was referring to. It needs to be the offset
> into the target, it can't be something else.
> 

I see both of you have explained this already, but I can't seem
to catch it yet.

Mind explaining me exaclty *why* "it can't be something else"?
IOW, why the window base address cannot be in the 2nd cell,
and/or what use cases would this encoding brake?

> I understand your motivation, but this is not a good method of
> encoding this in DT.
> 
> There is nothing especially wrong with updating the ranges at runtime,
> but don't use the 2nd cell in the 2dw address to encode the desired
> base address.
> 

Regarding this, let me confirm your proposed layout using an example.
(later on, i'll try the preprocessor on this to make it look better).

mbus {
	compatible = "foo-mbus";
	ranges = < 0xffff0001 0 0xf1000000 0x1000000 /* Internal register entry */
		   0x011d0000 0 0xfff00000 0x0100000 /* BootROM entry with base address */
		   0x012f0000 0 0xe8000000 0x1000000 /* DevBus,NOR entry with base address */
	>;

	bootrom {
		ranges = <0 0x011d0000 0 0x100000>;
	};

	devbus-bootcs {
		ranges = <0 0x012f0000 0 0x1000000>;
		nor {
			reg = <0 0x1000000>;
		};
	};
};

Is the above correct?

Now, if the above is OK, then the DT looks complete to me. Meaning:

1. There's no need to update any ranges property at runtime.

2. There's no need to use an algorithm to 'find' a base address for decoding
   windows (such as first-fit as Arnd suggested in another mail).
   The base address is already there in the ranges property, so the mbus can
   simply allocate the window on that base address.

So, am I right or completely lost?

Thanks a lot for the help,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
