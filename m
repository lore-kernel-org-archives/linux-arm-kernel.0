From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 7 Aug 2014 21:26:20 +0100
Subject: [PATCH 1/2] UEFI arm64: add noefi boot param
In-Reply-To: <20140807061945.GE20295@darkstar.nay.redhat.com>
References: <20140806083825.GA31711@dhcp-16-198.nay.redhat.com>
 <20140806130623.GI4179@bivouac.eciton.net>
 <20140806132021.GB15082@console-pimps.org>
 <20140806132941.GJ4179@bivouac.eciton.net>
 <20140806140155.GC15082@console-pimps.org>
 <CAKv+Gu8ey1iKu-_wS6yYaEXQaQMDXa+PF5Kiw+edA9a_OE1EAw@mail.gmail.com>
 <20140806141814.GD15082@console-pimps.org>
 <20140807061945.GE20295@darkstar.nay.redhat.com>
Message-ID: <20140807202620.GI15082@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Aug, at 02:19:45PM, Dave Young wrote:
> 
> The current efi_runtime_init() enables the bit after getting the efi
> callback phyaddr of SetVirtualAddressMap.
> 
> Thinking more about it, since SetVirtualAddressMap() could fail
> somehow it seems better to set EFI_RUNTIME_SERIVCES bit only when
> enter virtual mode return EFI_SUCCESS.
> 
> Does it make sense to you, Matt?

If you're going ahead with the scheme I proposed yesterday you'd
actually want to *clear* the EFI_RUNTIME_SERVICES bit if
SetVirtualAddressMap() fails, since we would have set it by default for
EFI_BOOT.

However, I still think we want to panic() if SetVirtualAddressMap()
fails because we really never expect that function to return an error
under normal circumstances. Also, I'm not sure it's safe to make any
assumptions about the state of the system if SetVirtualAddressMap()
fails.

-- 
Matt Fleming, Intel Open Source Technology Center
