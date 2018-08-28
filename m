From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Aug 2018 14:23:04 +0200
Subject: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Sunil Goutham <sgoutham@marvell.com>
>
> Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> PF0 is called administrative / admin function (AF) and has privilege access
> to registers to provision different RVU functional blocks to each of
> PF/VF.
>
> This admin function (AF) driver acts as a configuration / administrative
> software which provisions functional blocks to a PF/VF on demand for them
> to work as one of the following
>  - A basic network controller (i.e NIC).
>  - NIC with packet filtering, shaping and scheduling capabilities.
>  - A crypto device.
>  - A combination of above etc.
>
> PF/VFs communicate with admin function via a shared memory region.
> This patch series adds logic for the following
>  - RVU AF driver with functional blocks provisioning support
>  - Mailbox infrastructure for communication between AF and PFs.
>  - CGX driver which provides information about physcial network
>    interfaces which AF processes and forwards required info to
>    PF/VF drivers.
>
> This is the first set of patches out of 70 odd patches.
>
> Note: This driver neither receives any data nor processes it i.e no I/O,
>       just does the hardware configuration.

Hi Sunil,

Thanks for posting this first series, I'm glad we're seeing support for this
chip family making some progress.

My feeling overall is that we need a review from the network driver
folks more than the arm-soc team etc, and that maybe the driver
as a whole should go into drivers/net/ethernet.

We support some couple of similar hardware already that has
both support for virtual functions and for crypto offload, including
the Chelsio cxgb4, Mellanox mlx5, NXP DPAA and probably others,
and we need to ensure that the exposed interfaces are all
compatible, and that you use the correct subsystems and
in-kernel abstractions for thing that are common.

      Arnd
