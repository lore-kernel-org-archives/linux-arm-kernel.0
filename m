From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Mon, 19 Jun 2017 13:02:09 +0300
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com>
 <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
Message-ID: <20170619100209.GC629@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 09:50:49AM +0000, Gabriele Paoloni wrote:
> Many thanks for your response and your help here.
> 
> I guess that as conclusion with respect to the current v9 patchset we can
> disregard the idea of MFD and modify the current v9 so that it doesn't
> touch directly ACPI resources.
> Instead as I proposed before we can have the scan handler to enumerate
> the children devices and translate its addresses filling dev->resources[] and
> at the same time we can modify acpi_default_enumeration to check
> acpi_device_enumerated() before continuing with device enumeration...?
> 
> Do you think it as a viable solution?

No, I think MFD + scan handler inside the MFD driver is the way to go.
We don't want to trash ACPI core with stuff that does not belong there
IMHO.

Also you don't need to modify acpi_default_enumeration() because you can
mark your device enumerated in the MFD driver. So all the dirty details
will be in the MFD driver and not in ACPI core.
