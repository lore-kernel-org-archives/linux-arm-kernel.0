From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jan 2016 14:19:15 +0100
Subject: mainline build: 137 builds: 0 failed, 137 passed,
 296 warnings (v4.4-10454-g3e1e21c7bfcf)
In-Reply-To: <56a1c8c2.6953c20a.25484.ffff85a9@mx.google.com>
References: <56a1c8c2.6953c20a.25484.ffff85a9@mx.google.com>
Message-ID: <1605429.kGqaIzLx7t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 January 2016 22:14:26 kernelci. org bot wrote:
> Warnings summary:
> 
>     224  <stdin>:1307:2: warning: #warning syscall copy_file_range not implemented [-Wcpp]

I don't think anyone has sent this so far, sending a patch now.

>      29  drivers/tty/serial/amba-pl011.c:190:27: warning: 'vendor_zte' defined but not used [-Wunused-variable]

Patch sent a couple of days ago, got an Ack and waiting to be applied.

>      12  net/bluetooth/mgmt.c:5493:8: warning: 'r192' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      12  net/bluetooth/mgmt.c:5493:8: warning: 'h192' may be used uninitialized in this function [-Wmaybe-uninitialized]

This happens only in gcc-4.7 and gcc-4.8

>       5  crypto/wp512.c:987:1: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       1  crypto/wp512.c:987:1: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]

and this one only in gcc-4.7

Any chance we can update the toolchain on kernelci.org to 4.9 or higher?
I'm normally testing with gcc-5.2, which has a little better warnings.

>       2  drivers/gpu/drm/gma500/cdv_intel_dp.c:868:2: warning: 'i2c_dp_aux_add_bus' is deprecated (declared at ../drivers/gpu/drm/gma500/cdv_intel_dp.c:224) [-Wdeprecated-declarations]

x86-only, I'm not touching this.

>       2  /usr/include/x86_64-linux-gnu/bits/stdio2.h:64:3: warning: call to __builtin___snprintf_chk will always overflow destination buffer [enabled by default]

also x86-only, I don't even know what this comes from.

>       1  mm/page_alloc.c:5707:34: warning: array subscript is below array bounds [-Warray-bounds]



>       1  drivers/soc/qcom/spm.c:305:5: warning: 'found' may be used uninitialized in this function [-Wuninitialized]

Added a patch to arm-soc/fixes.

>       1  drivers/net/ethernet/marvell/mvneta.c:2910:30: warning: unused variable 'other_port' [-Wunused-variable]

Sent a patch to netdev today.

>       1  .config:930:warning: override: NOHIGHMEM changes choice state
>       1  .config:929:warning: override: SLOB changes choice state
>       1  .config:927:warning: override: KERNEL_XZ changes choice state
>       1  .config:884:warning: override: SLOB changes choice state
>       1  .config:839:warning: override: SLOB changes choice state
>       1  .config:837:warning: override: KERNEL_XZ changes choice state

Interesting: "make tinyconfig" first calls "make allnoconfig" and then calls
"make tiny.config", which in turn calls

   scripts/kconfig/merge_config.sh -m .config kernel/configs/tiny.config

and this overrides some choice statements, causing the warning. A better command
would be

   scripts/kconfig/merge_config.sh -n kernel/configs/tiny.config

which has the same effect but avoids the warning. Need to think about this
some more.

	Arnd
