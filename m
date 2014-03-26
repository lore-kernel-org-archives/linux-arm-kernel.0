From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Wed, 26 Mar 2014 20:34:19 +0000
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140326201243.GA1536@obsidianresearch.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com> <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
Message-ID: <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Wed, Mar 26, 2014 at 8:12 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
>
> So, we need a result that actually reads the vendor id..
>
> Here is a revision, I suspect the error with the debugging was not
> calling mvebu_pcie_set_local_bus_nr, so a type 1 transaction was being
> produced. I am looking for the 2nd Vendor ID to return 80861521.
>

Thanks. Here's the relevant output with that patch:

[    0.135772] mvebu-pcie pcie-controller.3: ICR is 0
[    0.160889] mvebu-pcie pcie-controller.3: Vendor ID is ffffffff
[    0.160897] mvebu-pcie pcie-controller.3: ICR is 800200
[    1.170215] mvebu-pcie pcie-controller.3: Try 2: Vendor ID is 15218086
[    1.170228] mvebu-pcie pcie-controller.3: ICR is 0
[    1.170290] mvebu-pcie pcie-controller.3: ICR is 0
[    1.170299] mvebu-pcie pcie-controller.3: Vendor ID is 10091b73
[    1.170306] mvebu-pcie pcie-controller.3: ICR is 0
[    2.180207] mvebu-pcie pcie-controller.3: Try 2: Vendor ID is 10091b73
[    2.180215] mvebu-pcie pcie-controller.3: ICR is 0

Success! For reference, the full dmesg is at https://gist.github.com/9792618

> Also, are you using the "reset-gpios" DT property?
>

I'm appending arch/arm/boot/dts/armada-370-mirabox.dtb to the kernel
image as the bootloader on the Mirabox is ancient and doesn't support
DTs. As far as I can see, there's no reset-gpios property anywhere in
that DT.

With regards to the bootloader, in case the information helps, it prints out:

PEX 0: Root Complex Interface, Detected Link X1
PEX 1: Root Complex Interface, Detected Link X1

As I am booting from the SD card, which is internally connected via
USB, the boot loader is obviously initialising the XHCI controller.
I'm guessing this is why it is detected immediately without needing
the delay.

Cheers,
Neil
