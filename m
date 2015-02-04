From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 04 Feb 2015 16:38:59 +0000
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150204162536.GJ8656@n2100.arm.linux.org.uk>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <8901765.mLfPOCUyAN@vostro.rjw.lan>
 <20150204104832.GF8656@n2100.arm.linux.org.uk>
 <CAErSpo71fVU5mJgXnxMwiE_TUrNyfSYHo5RDF-=u2BK5grDYAw@mail.gmail.com>
 <20150204162536.GJ8656@n2100.arm.linux.org.uk>
Message-ID: <1423067939.3011.72.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-02-04 at 16:25 +0000, Russell King - ARM Linux wrote:
> I haven't experimented with it myself, but I think David Woodhouse
> has some experience in this area.

In many kernel configurations there are actually quite a lot of
functions that are never called, and I was quite surprised the first
time I played with this stuff.

There are a few ways of dealing with it. One is to use
-ffunction-section -fdata-sections --gc-sections as you noted. I once
also played with using GCC's --combine during the brief period that it
was supported and not *entirely* broken, with similar effects:
https://lwn.net/Articles/197097/

These days, the better answer is probably LTO. We could potentially
still look at --gc-sections, but I suspect we're better off using LTO
and just filing toolchain bugs until everything that --gc-sections
*would* have dropped is also dropped from the LTO build :)

Unless --gc-sections actually speeds up the build in a significant way;
a full LTO link of the kernel takes insane amounts of memory IIRC.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150204/a5418034/attachment-0001.bin>
