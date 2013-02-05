From: amit.virdi@st.com (Amit Virdi)
Date: Tue, 5 Feb 2013 15:18:15 +0530
Subject: ARM/Kernel: Problems with multiple VIC registration
Message-ID: <5110D55F.9040509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I've picked Linux kernel 3.8-rc4 and added the support for my ARM based 
board in it.
- The SoC has 2 VICs
- valid_sources are 32 (~0)
- NR_IRQS is defined as 104; => irq_desc[104]
- I'm not populating devices thro' DT

The first controller is registered throu' irq_domain_add_linear API. As 
a result of this call, a new domain is allocated to the VIC device.

In the next step IRQ mapping, irq_create_mapping is called and this maps 
all the IRQs in the Linux IRQ space. However in doing so, it uses 
irq_desc[1]...irq_desc[32]. irq_dec[0] is not used (checked using a 
debugger)!

When I'm trying to register the second VIC (it's throu' 
irq_domain_add_legacy), I'm getting warnings since irq_get_irq_data 
returns irq_data of irq_desc[32] which has already been mapped.

In short, irq_domain_add_legacy returns with NULL irq_domain.

I checked that multiple VIC registration works in Linux 3.4
Is it something that I'm missing while adapting to the new framework, or 
there's some undetected problem?

I've attached the logfile generated with debug prints ON. Would 
appreciate any help...

Thanks
Amit Virdi
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: logfile.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/e095a301/attachment-0001.txt>
