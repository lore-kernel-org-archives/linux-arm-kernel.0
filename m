From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 19 Jun 2015 11:59:14 +0100
Subject: [PATCH v5 06/11] nvmem: Add bindings for simple nvmem framework
In-Reply-To: <20150619103647.GA3913@Sanchayan-Arch>
References: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226652-8947-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150619103647.GA3913@Sanchayan-Arch>
Message-ID: <5583F602.9040706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/06/15 11:36, maitysanchayan at gmail.com wrote:
> Hello Srinivas,
>
> On 15-05-21 17:44:12, Srinivas Kandagatla wrote:
>> This patch adds bindings for simple nvmem framework which allows nvmem
>> consumers to talk to nvmem providers to get access to nvmem cell data.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> [Maxime Ripard: intial version of eeprom framework]
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/nvmem/nvmem.txt | 84 +++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Documentation/devicetree/bindings/nvmem/nvmem.txt
>> new file mode 100644
>> index 0000000..ecea654
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
>> @@ -0,0 +1,84 @@
>> += NVMEM Data Device Tree Bindings =
>> +
>> +This binding is intended to represent the location of hardware
>> +configuration data stored in NVMEMs.
>> +
>> +On a significant proportion of boards, the manufacturer has stored
>> +some data on NVMEM, for the OS to be able to retrieve these information
>> +and act upon it. Obviously, the OS has to know about where to retrieve
>> +these data from, and where they are stored on the storage device.
>> +
>> +This document is here to document this.
>> +
>> += Data providers =
>> +Contains bindings specific to provider drivers and data cells as children
>> +to this node.
>> +
>> +Optional properties:
>> + read-only: Mark the provider as read only.
>> +
>> += Data cells =
>> +These are the child nodes of the provider which contain data cell
>> +information like offset and size in nvmem provider.
>> +
>> +Required properties:
>> +reg:	specifies the offset in byte within that storage device, start bit
>> +	in the byte and the length in bits of the data we care about.
>> +	There could be more then one offset-length pairs in this property.
>> +
>> +Optional properties:
>> +
>> +bit-offset: specifies the offset in bit within the address range specified
>> +	by reg property. Can take values from 0-7.
>> +nbits: specifies number of bits this cell occupies starting from bit-offset.
>> +
>> +For example:
>> +
>> +	/* Provider */
>> +	qfprom: qfprom at 00700000 {
>> +		...
>> +
>> +		/* Data cells */
>> +		tsens_calibration: calib at 404 {
>> +			reg = <0x404 0x10>;
>> +		};
>> +
>> +		tsens_calibration_bckp: calib_bckp at 504 {
>> +			reg = <0x504 0x11>;
>> +			bit-offset = 6;
>> +			nbits = 128;
>> +		};
>> +
>> +		pvs_version: pvs-version at 6 {
>> +			reg = <0x6 0x2>
>> +			bit-offset = 7;
>> +			nbits = 2;
>> +		};
>> +
>> +		speed_bin: speed-bin at c{
>> +			reg = <0xc 0x1>;
>> +			bit-offset = 2;
>> +			nbits	= 3;
>> +
>> +		};
>> +		...
>> +	};
>
> We have a need of exposing information like SoC ID, revision and such
> which is what this nvmem framework proposes to be suitable for. Till
> now I was trying a different approach for the same [1].
>
> The On Chip One Time Programmable block on the Vybrid can be handled
> nicely with this nvmem framework however I had a few queries with
> regards to the framework after trying it on a Vybrid VF61 SoC.
>
> 1. From what I understand, getting the information in hex is the only
> way possible as of now? Would it be possible to expose the information
nvmem file in the /sys/ is just a binary file. hexdump is one of the 
ways to dump the data, the user can read the binary file and interpret 
the data in the way he wants it.

> as strings from different paths under /sys/class/nvmem/*/nvmem/?
>
> For example, if I have a sub node as below
>
> ocotp: ocotp at 400a5000 {
> 	compatible = "fsl,vf610-ocotp";
> 	reg = <0x400a5000 0x1000>;
>
> 	ocotp_cfg0: cfg0 at 410 {
> 		reg = <0x410 0x1>;
> 	};
>
> 	ocotp_cfg1: cfg1 at 420 {
> 		reg = <0x420 0x1>;
> 	};
> };
>

> The values from the above register locations represented by the two
> sub nodes above can perhaps be exposed as strings? Even if they are
> not exposed as strings, making them available in separate paths, is
> that something which can be done? So depending on the sub node as
> above, /sys/class/nvmem/ocotp0/nvmem/cfg0/ would give values from
> the registers specified.

I was thinking of add similar support to show cells in 
/sys/class/nvmem/*/cells/cfg0 in future once the framework is merged. 
For now I want to keep it simple. This would be binary content again. 
you can dump it using strings any program which wants to interpret it 
differently.
>
> Basically the output of /sys/class/nvmem/*/nvmem being restricted
> to only the subnodes specified is what I was hoping to get along
> with separate paths.
>
> 2. What if the required information is scattered across different memory
> regions? In my case, the SoC ID is available from one OCOTP peripheral
> block, the revision is in a separate ROM area at the start of the memory
> map and some CPU information I am interested in is in another memory
> region. I am not sure what would be the right way to approach it with
> the nvmem framework.

I think you would have two providers in that case one is ocotp and other 
is ROM.
DT would look something like this:

/* Provider */
ocotp {
	...
	soc-id {
		reg = ...;
	};
};

rom {
	...
	soc-reg {
		reg = ...;
	};
};

/* consumer */
consumer {
	nvmem-cell  = <&soc_id>, <&soc_rev>;
	nvmem-cell-names = "soc-id", "soc-revision";
};

--srini
>
> [1] https://lkml.org/lkml/2015/6/5/189
>
> Thanks & Regards,
> Sanchayan Maity.
>
> <snip>
>
