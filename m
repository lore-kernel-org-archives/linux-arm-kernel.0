From: pratyush.anand@st.com (pratyush)
Date: Wed, 13 Apr 2011 17:55:25 +0530
Subject: [PATCH V7 02/17] SPEAr13xx: Add PCIe host controller base driver
	support.
In-Reply-To: <4DA47085.9090209@gmail.com>
References: <cover.1298977728.git.viresh.kumar@st.com>
	<6a4328fcb24af3fa28b2188864875cbecc6f533a.1298977728.git.viresh.kumar@st.com>
	<4DA47085.9090209@gmail.com>
Message-ID: <4DA59635.2020705@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

...

>> SPEAr13xx family contains Synopsys designware PCIe version 3.30a. This
>> patch adds support for this PCIe module for spear platform.
>>
> 
> Sorry for the late response.
> 
> Other vendors are likely to have the same IP, but none of the code here
> is written to be common. In light of recent discussions this would be a
> good candidate to avoid future duplication.
> 
> It doesn't appear that pcie.c contains much SPEAr specific code. The few
> defines and structs that are could be passed in. Some comments below.
> 

Yes, this driver is for an PCIe host which uses Synopsys IP. But 
SPEAr specific wrapper has been used heavily in the code.
Synopsis provides some signal which can be interfaced to registers
for CPU access. This interface can be different for different vendor.
All the application registers are SPEAr specific representation
and may not be same for other vendor.
So all accesses for app_reg in the code may not be similar in other 
implementation. 

...


>> +struct pcie_port {
> 
> 3 other structs with the same name and similar fields already exist:
> 
> arch/arm/mach-kirkwood/pcie.c:27:struct pcie_port {
> arch/arm/mach-dove/pcie.c:23:struct pcie_port {
> arch/arm/mach-mv78xx0/pcie.c:19:struct pcie_port {
> 
>> +     u8                      port;
>> +     u8                      root_bus_nr;
>> +     void __iomem            *base;
>> +     void __iomem            *app_base;
>> +     void __iomem            *va_app_base;
>> +     void __iomem            *va_dbi_base;


like dbi interface. May not be needed in all implementation
of the same synposis IP.

>> +     void __iomem            *va_cfg0_base;
>> +     void __iomem            *va_cfg1_base;
>> +     spinlock_t              conf_lock;
>> +     char                    mem_space_name[16];
>> +     char                    io_space_name[16];
>> +     struct resource         res[2];
>> +     struct pcie_port_info   config;
>> +};
>> +

...

Regards
Pratyush
