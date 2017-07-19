From: andrea.adami@gmail.com (Andrea Adami)
Date: Wed, 19 Jul 2017 15:13:29 +0200
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled with
 gcc7
Message-ID: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

with the same toolchain, only changing from gcc6.3.0 to gcc7.1.0, the
kernel does not boot: using xz the decompression fails with
"XZ-compressed data is corrupt" / XZ_DATA_ERROR.

I think it might be this line in lib/xz/xz_dec_stream.c

    s->vli |= (vli_type)(byte & 0x7F) << s->pos;

Here gcc6 is using __aeabi_llsl

Looking at the disassembled sources, do you see evident issues in dec_vli()?
Kernel is built optimized for size. I am uploading the logs and huge
build dirs [1]

Pls look under /disassembled. Suffix is the gcc version.

decompress6.S -> built with  gcc6
decompress7.S -> built with  gcc7

I am puzzled because the same toolchain produces valid kernel for
qemuarm versatile-926ejs.

Finally, a short test with gzip compressed kernel shows it does not
boot as well so maybe the issue is another. I don't have serial here
now but I'll take more logs if necessary.

Thanks
Andrea

[1] https://github.com/andrea-adami/gcc7-kernel-debug
