From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 18 Mar 2016 18:49:18 +0300
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <56EBD84D.2060009@huawei.com>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <56AB3805.1040308@huawei.com> <20160129170929.GA3543@yury-N73SV>
 <56AC38F1.2030608@huawei.com> <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de>
 <20160225202855.GD16123@yury-N73SV> <56EBD84D.2060009@huawei.com>
Message-ID: <20160318154918.GA1595@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 06:28:29PM +0800, Zhangjian (Bamvor) wrote:
> Hi, Yury
> 
> We are trying to test ilp32 in our arm64 board. But we got more
> failure compare with you. So, I am wondering if we could align
> the test environment with you. The source code we used:
> 

Hi, I mostly use QEMU but Thunder X CPU works similarly. I also
noticed that some tests fail sporadically, and some fail only in
scenario. The current fail list, as for me, is at the bottom.

Below links to my sources.

> 1.  glibc: the new-api branch of glibc from
>     git at code.huawei.com:gnu/norov_glibc.git.

It has few bugfixes:
https://github.com/norov/glibc/tree/new-api

> 
> 2.  Kernel: rfc5 from https://github.com/norov/linux.git. Is the
>     rc6 in your branch is the latest one? From the commit message, I
>     do not find any difference. Is it just a rebase?

https://github.com/norov/linux/tree/pin1
This branch is v4.5 plus
 - Andrew's Thunder X patches (not mandatory);
 - http://comments.gmane.org/gmane.linux.kernel/2116021
 - http://comments.gmane.org/gmane.linux.kernel/2162853
 - current ILP32 (RFC5 + few fixes)

> 
> 3.  Toolchain 4.9.3, could you provide the binary of toolchain(both
>     cross and native, gcc, gdb...)? It may be very useful for me or
>     other guys who interested build their own filesystem from
>     buildroot or something.

I use one Andrew gave me. AFAIK, he's preparing useful package.
Andrew?

I use this cross-toolchain. Find sys-root under aarch64-thunderx-linux-gnu/
https://drive.google.com/file/d/0B93nHerV55yNdXBlVTRLNzF0aFE/view?usp=sharing

> 
> 4.  LTP: master.

Find LTP here:
https://drive.google.com/file/d/0B93nHerV55yNSTlZX3drRTBCaEU/view?usp=sharing

Notice that I configure it with command:
echo $(PREFIX)
        /home/yury/work/toolchain/thunderx-tools/
./configure --host=aarch64 --prefix=/home/yury/work/ltp/ltp \
CC=$(PREFIX)/bin/a arch64-thunderx-linux-gnu-gcc \
AR=$(PREFIX)/bin/aarch64-thunderx-linux-gnu-ar \
STRIP =$(PREFIX)/bin/aarch64-thunderx-linux-gnu-strip \
RANLIB=$(PREFIX)/bin/aarch64-thunderx-linux-gnu-ranlib  \
CFLAGS=-mabi=ilp32 \
LDFLAGS=-mabi=ilp32 -Wl,--rpath=/root/sys-root/libilp32 \
-Wl,--dynamic-linker=/root/sys-root/libilp32/ld-2.21.90.so

Notice that you don't need to place experimental sys-root to system paths,
but path is hardcoded to '/root/sys-root'

> 
> For the glibc part, I found that there are 11 patches of ilp32 in top,
> but the original 28 patches of ilp32 is not in the top, there are more
> than 900 patches between them(referece the list below). Are you
> willing rebase all the ilp32 relative patches. It is very useful for
> reviewing and debugging.  I saw andrew request the account in glibc,
> maybe it has already been in processs?).
> 

I already told there's mess there, and I'd prefer to make things work
first and then do cleanup. 

Yury.

Total Tests: 787
Total Skipped Tests: 25
Total Failures: 24

float_bessel                   FAIL       137
float_exp_log                  FAIL       137
float_iperb                    FAIL       137
float_power                    FAIL       137
float_trigo                    FAIL       137
abort01                        FAIL       2
clone02                        FAIL       4
fcntl11                        FAIL       4
fcntl21                        FAIL       4
kill10                         FAIL       2
kill11                         FAIL       2
mmap16                         FAIL       6
nftw01                         FAIL       1
nftw6401                       FAIL       1
open12                         FAIL       2
pathconf01                     FAIL       1
profil01                       FAIL       11
rename11                       FAIL       2
rmdir02                        FAIL       2
umount2_01                     FAIL       2
umount2_02                     FAIL       2
umount2_03                     FAIL       2
utime06                        FAIL       2
mtest06                        FAIL       11
