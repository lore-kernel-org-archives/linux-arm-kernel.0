From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 19 Jul 2014 12:31:19 +0200
Subject: [PATCH v10 0/8] ARM: berlin: add AHCI support
In-Reply-To: <53CA4608.3040208@redhat.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140718135758.GB13012@htj.dyndns.org> <53CA4608.3040208@redhat.com>
Message-ID: <53CA48F7.5020405@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/19/2014 12:18 PM, Hans de Goede wrote:

<snip>

> The problem is that:
>
> 1) We need to enable resources before we can do ahci_save_initial_config()
> 2) We must do ahci_save_initial_config() before we can do ata_host_alloc_pinfo()
> 3) Therefor we don't have port_info at enable_resources time, which is when we
> want to enable the phys (and we cannot just enable the phys elsewhere as
> enable_resouces gets used on e.g. resume too).
>
> So I think it is best to just make the phy pointers an array inside
> ahci_host_priv, with a comment that the array indexes must match port
> indexes.

So looking at "[PATCH v10 4/8] ata: libahci: allow to use multiple PHYs"
I see that currently the phy array indexes do not necessarily match the
port indexes. Since you already allocate the phys array at nports size,
I suggest simply making the array sparse, leaving in NULL entries for
unused ports, and adjusting enable / disable_phys to check for NULL
pointers. This way we still have a 1:1 way to map ports <-> phys if
we want to do something with phys on a per port basis in the future.

Note please also add a check that reg < nports so that we don't use
the array out of bounds if there is an error in the dts.

<snip>

Regards,

Hans
