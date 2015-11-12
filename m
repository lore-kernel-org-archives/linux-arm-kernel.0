From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Nov 2015 16:12:24 +0800
Subject: aarch64-linux-gnu-objdump gives all zeros in init_sequence_f[]
In-Reply-To: <CAKv+Gu8KyP8YQzhiJu6ThnMJCUc2U9mUhJk6mdxL3PGcV59Bcw@mail.gmail.com>
References: <20151112054316.GA5043@dragon>
 <CAKv+Gu8KyP8YQzhiJu6ThnMJCUc2U9mUhJk6mdxL3PGcV59Bcw@mail.gmail.com>
Message-ID: <20151112081223.GB5043@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 07:36:02AM +0100, Ard Biesheuvel wrote:
> On 12 November 2015 at 06:43, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Here are my questions:
> >
> > - Is this only because that ARM 64-bit toolchain doesn't show the real
> >   value of the pointers, or there are some linking or run-time magics to
> >   get these pointers correct when the binary is actually running?
> >
> 
> AArch64 uses the ELF RELA relocation format, where the target location
> of the relocation is not used to hold the addend. In contrast, ARM
> uses the REL format, where the addend is stored in the same place
> where the result of the relocation computation needs to be stored.
> 
> Since U-Boot is a PIE executable, it makes heavy use of
> R_ARM_RELATIVE/R_AARCH64_RELATIVE relocations, which are not symbol
> based, but simply point to places in the binary such as your init
> array) where the offset between the link time and load time addresses
> needs to be taken into account. For this type of relocation (and since
> the u-boot link time base address is 0x0), the addends happen to
> coincide with the actual addresses of the functions. These relocations
> are applied at runtime by u-boot itself, since it moves itself to the
> top of DRAM right after boot.
> 
> In the AArch64 case, these addends are stored in the relocation
> entries themselves. If you dump the relocations form the u-boot binary
> using readelf, you will probably find the values you are looking for.

Thanks a lot for the pointer, Ard.  With your hints, I'm looking at
U-Boot commit 8137af19e75a (arm64: Add tool to statically apply RELA
relocations) and getting the idea how this thing works on arm64.

Thanks again.

Shawn
