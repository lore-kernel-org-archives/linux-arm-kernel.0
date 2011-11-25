From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 25 Nov 2011 21:42:46 +0800
Subject: [PATCH v2] PM: HIBERNATION: skip the swap size check if the
 snapshot image size is anticipative
In-Reply-To: <4ECF6C36.8000702@parrot.com>
References: <1322208422-12346-1-git-send-email-Barry.Song@csr.com>
 <4ECF6C36.8000702@parrot.com>
Message-ID: <CAGsJ_4yse3kjRd+GGeZ81WEJPM0gEX=Ljik_EpGjnwS8pjxfMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthieu,

2011/11/25 Matthieu CASTET <matthieu.castet@parrot.com>
>
> Hi,
>
> but did embedded system will really use swap interface ?

if you self-define the hibernation flow, you don't need swap. but for
embedded system, we actually can still use the standard flow, swapon
before hibernation, and swapoff after restore. so the swap partition
only works as a partition to save used pages based on swap format. it
is not a runtime swap partition at all.

>
> Often they don't have swap and can already save suspend image in disk/nand :
> - SNAPSHOT_CREATE_IMAGE
> - read it from /dev/snapshot and write it to a file.
>
> The only problem with the current interface, is that you can't SNAPSHOT_UNFREEZE
> before reading the image.
> But this is need for some filesystem that have thread.
>
>
> For example we have a demo where we save the suspend image in a ubi volume and
> restore it from bootloader.
yes. we can definitely resume snapshot from bootloader directly, that
depends on your self-defined hibernation flow. if that works well, it
will save about 0.5s kernel boot time for a typical cortex-a9 ARM 1Ghz
system.

but you still need to take care you only compress and save used pages
but not all pages. sync, drop page caches and kill non-system
processes will help much to decrease hibernation image size. and
standard hibernation flow will only save used pages, that is very
important for decreasing snapshot size and restore faster.

i am happy to hear you have a demo. do you have a website to show your
demo and techinical details?

>
>
> Matthieu
>
-barry
