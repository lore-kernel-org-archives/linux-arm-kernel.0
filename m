From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jan 2013 21:08:59 +0000
Subject: Compilation problem with drivers/staging/zsmalloc when !SMP on ARM
In-Reply-To: <CAKGA1b=ACTQHo9=B7EAG5nrFCO9u-J+sy7dXtYk3Rk6OUcW3cQ@mail.gmail.com>
References: <CAKGA1b=ACTQHo9=B7EAG5nrFCO9u-J+sy7dXtYk3Rk6OUcW3cQ@mail.gmail.com>
Message-ID: <20130118210859.GH23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 02:24:15PM -0600, Matt Sealey wrote:
> Hello all,
> 
> I wonder if anyone can shed some light on this linking problem I have
> right now. If I configure my kernel without SMP support (it is a very
> lean config for i.MX51 with device tree support only) I hit this error
> on linking:

Yes, I looked at this, and I've decided that I will _not_ fix this export,
neither will I accept a patch to add an export.

As far as I can see, this code is buggy in a SMP environment.  There's
apparantly no guarantee that:

1. the mapping will be created on a particular CPU.
2. the mapping will then be used only on this specific CPU.
3. no guarantee that another CPU won't speculatively prefetch from this
   region.
4. when the mapping is torn down, no guarantee that it's the same CPU that
   used the happing.

So, the use of the local TLB flush leaves all the other CPUs potentially
containing TLB entries for this mapping.

Finally, there is no TODO file for this driver, which I believe is a
requirement for anything to be in stable.  So as far as I can see, it
should be deleted or a TODO file added.  I'm not sure why Greg decided
to add it without a TODO file.

(If there was such a file, I'd have added the above to it.  As it is,
I've just decided to disable the thing in my randconfig builds.)
