From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Jan 2015 18:28:34 +0000
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <54CA7A42.5080800@codeaurora.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
 <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
 <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
 <54C92804.5090806@codeaurora.org>
 <20150129151956.GF8951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
 <54CA7A42.5080800@codeaurora.org>
Message-ID: <CAKv+Gu_a6_zjt=MsRuQH2rr05XxDayy0gACtbPXZaDAyhWrigg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2015 at 18:21, Timur Tabi <timur@codeaurora.org> wrote:
> On 01/29/2015 12:20 PM, Ard Biesheuvel wrote:
>>
>> If we are going with this solution, we should also mandate that an
>> ACPI enabled firmware should not supply a non-DT DTB
>
>
> What is a non-DT DTB?  I thought the "DT" in "DTB" stood for device tree.
>

The UEFI stub in the kernel uses the DTB file format (FDT) to pass
information about the UEFI memory map and system table to the kernel.
It does so even if there is no device tree that describes the
platform. In this case, the file only contains a /chosen DT node, and
nothing else, and it is up to the kernel to figure out that it can ask
UEFI for a set of ACPI tables that it can use instead to configure the
system. Otherwise, the /chosen node properties are added to a device
tree that contains the full platform description.

The problem is that we have to decide how to distinguish a
conventional device tree DTB from a DTB that only exists to
communicate the UEFI entry points.
