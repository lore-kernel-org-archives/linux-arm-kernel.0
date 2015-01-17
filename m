From: jcm@redhat.com (Jon Masters)
Date: Sat, 17 Jan 2015 15:12:13 -0500
Subject: SMBIOS/DMI data under CONFIG_STRICT_DEVMEM
Message-ID: <54BAC21D.9040009@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, all,

I would like to ensure that the SMBIOS data provided by firmware is
always readable from userspace on AArch64, through /dev/mem.

When building a kernel with CONFIG_STRICT_DEVMEM, arm64 follows broadly
x86 with the exception of an assumption surrounding the low range of
memory (which doesn't apply on AArch64 platforms universally anyway).
Thus on x86, they can directly read the SMBIOS table from dmidecode when
it tries to map /dev/mem due to its location. I'm hacking something up
for the moment, but I would like to solve this.

Here are two questions:

1). Would you prefer to add e.g. a devmem_is_firmware_table() function
that is called by devmem_is_allowed and carves out a couple exceptions
based upon knowing .e.g dmi_base and other dynamic data during boot?

2). Would you prefer to reserve the DMI region is an iomem resource?
That's a hack but it would seem to work since your check should then
result in the kernel's resource management saying this is not RAM. The
problem with this option is that you would then only be able to read the
SMBIOS tables from userspace if the kernel also recognized them (i.e.
option 1 above just checks the reported range from EFI, but this option
would rely on the kernel DMI code also validating the tables, so if you
were debugging or whatever you wouldn't be able to read them without
building your kernel without CONFIG_STRICT_DEVMEM for e.g.).

I'm also curious whether x86 is interested in changing the way that the
SMBIOS tables are accounted or if there are other suggestions.

Jon.
