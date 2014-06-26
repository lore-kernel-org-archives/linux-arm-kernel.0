From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 26 Jun 2014 07:59:19 -0700
Subject: mainline boot: 64 boots: 62 pass, 2 fail (v3.16-rc1-2-gebe0618)
In-Reply-To: <53ABC13C.8030908@gmail.com>
References: <539fdd37.e7bc420a.76b9.ffffb583@mx.google.com>
 <CAGa+x85nqPbH-sye28ni=gUEdgjGdUDqHhv1+0pV5aO8y1+wHQ@mail.gmail.com>
 <53A106F1.10201@gmail.com>
 <CAGa+x8527FEPk6fg5kv-fbOzK3MzcFooFGE9Me12b9C_Pv=UzA@mail.gmail.com>
 <53A2AE11.2050208@gmail.com> <53A2BE94.2010308@gmail.com>
 <53A7A579.4010702@gmail.com>
 <CAGa+x85H510fNGTXJHGYfQybRa2FGgg2NyCgJ8rmjJ6TE7GNbA@mail.gmail.com>
 <53A9B99F.4040806@codeaurora.org> <53A9FBB5.60709@codeaurora.org>
 <53AABCF5.4050403@gmail.com> <53AB45D1.90909@codeaurora.org>
 <53ABC13C.8030908@gmail.com>
Message-ID: <CAGa+x84UTbmFc2Twg9zEcr+ZP2xsq68gFvk=385+_cFM5hvGHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

> Here is my assessment of the current situation.

Thanks for digging into this and the detailed diagnosis.

> *Bug in the u-boot*
> Current u-boot for Arndale-octa board has defined NR_BANKS as 12 and the
> core uses a global structure (gd->bd) to maintain the start and size of
> individual banks. Depending on the revision of SoC used on the board,
> the board file [1] updates the start/size for either 8 or 12 banks. In
> case of current revision of Arndale-Octa boards, the board file always
> updates start/size for 8 banks, leaving the start/size data for
> remaining 4 banks uninitialized.
>
> But the u-boot core[2] updates the value of all the 12 banks, thus
> potentially updating invalid data for last 4 banks.
>
> The issue can be fixed by resetting the start/size for unused memory
> banks to 0/0.[3]
>
> *Before migration to memblock*
> The path for adding DRAM banks was done through [4]. For Exynos systems,
> NR_BANKS was defined as 8. The initial check for rejecting any banks
> beyond NR_BANKS was good enough for fixing this issue. The bootlog[5]
> (with some debug messages) shows the invalid data, both in u-boot and
> kernel. Please grep for "NR_BANKS too low, ignoring memory" in the bootlog.
>
> *After migration to memblock*
> Now that the memory banks are added through [6], all the memory banks
> are getting updated unconditionally resulting in the panic.
>
> IMO, the bug is in u-boot and we should fix that.

I agree that the u-boot bug needs to be fixed, and FWIW, I updated my
u-boot and haven't seen the boot failure yet after several boots with
next-20140625.

That being said, since it's not always feasible/practical to update
u-boot, and when it comes down to it, this is still a kernel
regression, we should also fix the kernel to sanity check the values
coming from u-boot, like it was doing before.

Could you (or Laura) come up with a way to recreate the sanity check
that was detecting this problem before and ignoring those banks?

Thanks,

Kevin
