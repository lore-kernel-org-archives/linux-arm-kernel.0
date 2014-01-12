From: lho@apm.com (Loc Ho)
Date: Sat, 11 Jan 2014 19:58:04 -0800
Subject: [PATCH v8 3/4] ata: Add APM X-Gene SoC SATA host controller driver
In-Reply-To: <20140111193104.GD3257@mtj.dyndns.org>
References: <1389031922-4309-1-git-send-email-lho@apm.com>
 <1389031922-4309-2-git-send-email-lho@apm.com>
 <1389031922-4309-3-git-send-email-lho@apm.com>
 <1389031922-4309-4-git-send-email-lho@apm.com> <52D052F9.8050703@redhat.com>
 <20140111193104.GD3257@mtj.dyndns.org>
Message-ID: <6EB44142-06DA-4C9D-8999-CFA9EE30E03D@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Jan 11, 2014, at 11:31 AM, Tejun Heo <tj@kernel.org> wrote:
> 
> Hello, David.
> 
>> On Fri, Jan 10, 2014 at 02:07:21PM -0600, David Milburn wrote:
>> Tejun, to avoid some of the interrupt handling code duplication, would
>> it better to have a AHCI_HFLAG_FLUSH and then change
>> 
>> this driver to set flush
>> 
>> hpriv->hpriv.flush = (void *) xgene_ahci_iob_flush;
>> 
>> and then standard code flush when necessary
>> 
>> ahci_handle_port_interrupt
>> 
>>       /* board-specific flush before servicing completed cmds */
>>       if (hpriv-> flags & AHCI_HFLAG_FLUSH)
>>               hpriv->flush(hpriv);
> 
> And this would be the only spot that this would be necessary?  If so,
> why not just wrap the interrupt handler?

The flush has to occurred immediately after reading the CI register. It can not wrap around the isr routine and issue the flush after or before the library ahci isr routine.

-Loc
