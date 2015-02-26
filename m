From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 26 Feb 2015 17:18:41 +0900
Subject: [PATCH v4 2/8] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <6850624.bdB2Ab6zJx@wuerfel>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <7412525.l6YnQcTxtg@wuerfel> <54EC5AB1.5090802@samsung.com>
 <6850624.bdB2Ab6zJx@wuerfel>
Message-ID: <54EED6E1.4060908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2015 08:59 PM, Arnd Bergmann wrote:
> On Tuesday 24 February 2015 20:04:17 Chanwoo Choi wrote:
>> On 02/24/2015 06:48 PM, Arnd Bergmann wrote:
>>> On Tuesday 24 February 2015 17:52:01 Chanwoo Choi wrote:
>>>>
>>>> But, I have a question.
>>>> If we put the aliases into the board dts file instaed of SoC dtsi,
>>>> each board dts file may use the different alias name about same phandle.
>>>
>>> Yes, that is the idea. In particular with the uarts, the intention is
>>> that the numbering of the device nodes in /dev is the same that is
>>> printed on the board (if any), which may be different from the numbering
>>> internal to the SoC.
>>
>> I check the uart device with Exynos5433 SoC based on Linux 4.0-rc1
>> If some board use the serial_0 and serial_3 as following in board dtsi,
>>
>>         &serial_0 {             --> UART 0 device
>>                 status = "okay";
>>         };
>>
>>         &serial_3 {             --> UART 3 device
>>                 status = "okay";
>>         };
>>
>> The serial core driver create the follwoing /dev/ttySACx device node
>> by using the number of alias. It maintain the same device number of internel to the SoC.
>>
>>         root at localhost:~# ls /dev/ttySAC
>>         ttySAC1  ttySAC3  
>>
> 
> I'm not completely following. So you have set the serial1 alias to
> the &serial_0 device node and serial3 to &serial_3?
> 
> Why not use serial0=&serial_0 and serial1=&serial_3? Does the serial0
> alias have a special meaning?

I add following aliases and serial_1/serial_3 dt node in board dtsi:
I tested that change the alias of serial_x node.
	
	aliases {
		serial0 = &serial_1;
		serial1 = &serial_3;
	};

	/* Add 'linux,stdout-path' property to print kernel log by using ealycon */
	chosen {
		linux,stdout-path = &serial_1;
	};

	[snip]

	/* serial_1 is used for printing kernel log throught JIG cable */
	&serial_1 {
		status = "okay";
	};

	&serial_3 {
		status = "okay";
	};

In result, serial driver create the /dev/ttySAC0 for serial_1 and /dev/ttySAC1 for serial_3.
But, I cannot complete the kernel booting and stop it with following kernel log

[    0.000000] Booting Linux on physical CPU 0x100
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0-rc1-00066-g49bfcec-dirty (cwchoi00 at chan) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG l5
[snip]
[    0.000000] Kernel command line: console=ttySAC1,115200 earlycon=exynos4210,0x14C20000
[snip]
[    0.651647] dma-pl330 15610000.pdma: Loaded driver for PL330 DMAC-341330
[    0.651851] dma-pl330 15610000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.658566] dma-pl330 15600000.pdma: Loaded driver for PL330 DMAC-341330
[    0.662872] dma-pl330 15600000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.672487] dma-pl330 11420000.adma: Loaded driver for PL330 DMAC-341330
[ 8466.414900] dma-pl330 11420000.adma:         DBUFF-8x8bytes Num_Chans-8 Num_Peri-16 Num_Events-8
[ 8466.481648] 14c20000.serial: ttySAC0 at MMIO 0x14c20000 (irq = 21, base_baud = 0) is a S3C6400/10
(dont' print any kernel log)

So, I change the kernel command line about ('console' bootparam) as following:
because tty framework must use the 'console' bootparam to print kernel log.
- original     : Kernel command line: console=ttySAC1,115200 ... (cannot the kernel log from serial driver probed)
- modification : Kernel command line: console=ttySAC0,115200 ... (got the successful kernel booting)

After modification, I got the successful kernel booting.

If should use the serial_0 device and then modify the 'aliases' as following:
I have to modify the commandline of bootloader if the commandline of bootloader is used
instad of default kernel command line.

	aliases {
		serial0 = &serial_0;
		serial1 = &serial_1;
		serial2 = &serial_3;
	};

Thanks,
Chanwoo Choi
