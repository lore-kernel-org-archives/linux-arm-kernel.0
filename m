From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Wed, 11 Jul 2012 18:26:30 +0530
Subject: Device tree binding for DVFS table
Message-ID: <4FFD77FE.8050206@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am working on DT binding for Tegra DVFS.

For Tegra, DVFS node mainly consists of frequency and voltage pairs. 
Frequency in the pair may change for different process. E.g. for process 
1 CPU clock frequency could be 900MHz at 1V while for process 2 it could 
be 1GHz at 1V.
Tegra uses vendor specific ids to identify the correct frequency table.

Following is the proposed binding for voltage and frequency tables used 
in DVFS. Looking for comments/suggestions to make it generic.

=======DVFS table node===================
This node defines the voltage configuration for the DVFS which includes 
the regulator and voltage array.

Required properties:

reg_id : <regulator phandle>;
voltage-table : <voltage array, values in mV>;

#address-cells and #size-cells : To identify correct frequency table 
using process id (or some other vendor specific way).

========Frequency table node===============

This node defines frequency configuration for the device DVFS.

Required properties:

In device node need a reference to the DVFS table node.

dvfs : the phandle for the DVFS table node

frequency-table at n
        reg = <n>; dependent on address-cells and size-cells in DVFS 
table node.
        frequencies = <frequency array, values in MHz>;
}

Example:
-------------------------------------------------------------------------

cpu-dvfs-table : dvfs-table {
               compatible = "nvidia,tegra30-dvfs-table";
               reg_id = <&sm0>;
               #address-cells = <1>;
               #size-cells = <0>;
               voltage-array = <750 775 800 825 850 875 900 925 950 975 
1000 1025 1050 1100 1125>;
};

device {
              dvfs = <&cpu-dvfs-table>;
              frequency-table at 102 {
                       reg = <0x102>;
                       frequencies = <314 314 314 456 456 456 608 608 
608 760 817 817 912 1000>;
              };
              frequency-table at 002 {
                       reg = <0x002>;
                       frequencies = <598 598 750 750 893 893 1000>;
              };
};

Thanks & Regards,
Prashant G
