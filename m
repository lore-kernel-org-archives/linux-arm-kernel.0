From: joel.schopp@amd.com (Joel Schopp)
Date: Mon, 11 Aug 2014 15:21:41 -0500
Subject: [PATCH v3] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140811191938.GJ10550@cbox>
References: <20140804143845.2851.85441.stgit@joelaarch64.amd.com>
 <20140808204612.GC14205@cbox> <53E8DF49.4080002@amd.com>
 <20140811191938.GJ10550@cbox>
Message-ID: <53E925D5.4050102@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>> That said, I don't think this is doing the right thing.  I think you
>>> want to refuse running the VM and avoid any stage-2 entried being
>>> created if this is not the case (actually, we may want to check this
>>> after set_vttbr_baddr_mask() or right aftert allocating the stage-2
>>> pgd), because otherwise I think we may be overwriting memory not
>>> belonging to us with concatenated page tables in a 42-bit 4KB system,
>>> for example.
>> My experience here was that the hardware actually catches the error on
>> the first instruction load of the guest kernel and does a stage 2
>> translation abort.  However, to be extra safe we could just log the
>> error with the address of the vttbr and then zero out the pgd_phys part
>> of vttbr altogether, leaving only the vmid.  The guest would then die of
>> natural causes and we wouldn't have to worry about the outside
>> possibility of memory getting overwritten.
> uh, putting zero in the pgd_phys part will just point to random memory
> if you happen to have memory based at address 0 though, right?
>
> I think we should check when we allocate the pgd that it is indeed of
> the right size and alignment, and if it isn't at this point, it truly is
> a BUG() and your kernel is terribly busted.
If I can't rely on 0 to be an invalid address I can't think of what I
could rely on to be invalid.  I'll just change this to BUG_ON(pgd_phys &
~vttbr_baddr_mask); and give up on my dream of the host kernel surviving
the bug.
