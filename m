From: Satha.Rao@cavium.com (Koteshwar Rao, Satha)
Date: Mon, 26 Dec 2016 14:20:21 +0000
Subject: [RFC PATCH 1/7] PF driver modified to enable HW filter support,
 changes works in backward compatibility mode Enable required things in
 Makefile Enable LZ4 dependecy inside config file
In-Reply-To: <CA+sq2CfwTN5u6nhxriqWqoFxsYHdEYikbjBgMCL2YwNXpqyQ=Q@mail.gmail.com>
References: <1482310011-1862-1-git-send-email-satha.rao@caviumnetworks.com>
 <1482310011-1862-2-git-send-email-satha.rao@caviumnetworks.com>
 <CA+sq2CfwTN5u6nhxriqWqoFxsYHdEYikbjBgMCL2YwNXpqyQ=Q@mail.gmail.com>
Message-ID: <DM5PR07MB28428EE7B1679FAEC78103AD8D960@DM5PR07MB2842.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Responses inline

Thanks,
Satha

-----Original Message-----
From: Sunil Kovvuri [mailto:sunil.kovvuri at gmail.com] 
Sent: Wednesday, December 21, 2016 5:05 AM
To: Koteshwar Rao, Satha
Cc: LKML; Goutham, Sunil; Robert Richter; David S. Miller; Daney, David; Vatsavayi, Raghu; Chickles, Derek; Romanov, Philip; Linux Netdev List; LAKML
Subject: Re: [RFC PATCH 1/7] PF driver modified to enable HW filter support, changes works in backward compatibility mode Enable required things in Makefile Enable LZ4 dependecy inside config file

>
>  #define NIC_MAX_RSS_HASH_BITS          8
>  #define NIC_MAX_RSS_IDR_TBL_SIZE       (1 << NIC_MAX_RSS_HASH_BITS)
> +#define NIC_TNS_RSS_IDR_TBL_SIZE       5

So you want to use only 5 queues per VF when TNS is enabled, is it ??
There are 4096 RSS indices in total, for each VF you can use max 32.
I guess you wanted to set no of hash bits to 5 instead of table size.

SATHA>>> We enabled 8 queues for VF. Yes Macro name misleads it has to be hash bits, will change this in next version

>  #define RSS_HASH_KEY_SIZE              5 /* 320 bit key */
>
>  struct nicvf_rss_info {
> @@ -255,74 +258,6 @@ struct nicvf_drv_stats {
>         struct u64_stats_sync   syncp;
>  };
>
> -struct nicvf {
> -       struct nicvf            *pnicvf;
> -       struct net_device       *netdev;
> -       struct pci_dev          *pdev;
> -       void __iomem            *reg_base;

Didn't get why you moved this structure to the end of file.
Looks like an unnecessary modification.
SATHA>>> Previously we have some dependency, we look into this, and address in next verison

> +static unsigned int num_vfs;
> +module_param(num_vfs, uint, 0644);
> +MODULE_PARM_DESC(num_vfs, "Non zero positive value, specifies number 
> +of VF's per physical port");

So what if driver is built-in instead of module, I can't use TNS is it ?
SATHA>>> Still you can enable this special features by passing boot argument "nicpf.num_vfs=X"

>
> +/* Set RBDR Backpressure (RBDR_BP) and CQ backpressure (CQ_BP) of 
> +vnic queues
> + * to 129 each

Why 129 ??
RBDR minimum size is 8K buffers, why you want to assert BP when still ~4K buffers are available. Isn't 4K a huge number to start asserting backpressure ?
SATHA>>> As CQ count was 4K entries, I used same BP value for both, will address this in next version
