From: sbranden@broadcom.com (Scott Branden)
Date: Fri, 27 Nov 2015 15:49:32 -0800
Subject: [PATCH 1/1] kconfig: add CPU endian selection beconfig and
 leconfig
In-Reply-To: <5658A368.7080509@gmail.com>
References: <1448567995-8784-1-git-send-email-sbranden@broadcom.com>
 <1448567995-8784-2-git-send-email-sbranden@broadcom.com>
 <5658A368.7080509@gmail.com>
Message-ID: <5658EC0C.1030305@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 15-11-27 10:39 AM, Florian Fainelli wrote:
> Le 26/11/2015 11:59, Scott Branden a ?crit :
>> Add support for switching defconfig between big and little endian CPU.
>> Various CPU types have ability to select big and little endian
>> CPU in the kernel configuration.
>>
>> "make beconfig" will set CONFIG_CPU_BIG_ENDIAN
>> "make leconfig" will unset CONFIG_CPU_BIG_ENDIAN
>
> I believe I understand what you are trying to achieve here, which is to
> have an identical defconfig file that you can share between a big-endian
> and little-endian kernel?
You understand correct - ARM64 maintainers have only allowed 1 defconfig 
upstream and it supports little endian.  And it doesn't make sense to 
have another defconfig with a single line difference upstreamed.  Yet 
the defconfig does not allow the system to boot in big endian mode.
>
> Is not this something better left to a build system which understands
> what config fragments are in general?
Every build system would need to invent their own procedure.  By adding 
this into the upstream kernel there is no need to.
make defconfig
make beconfig (or make leconfig)
make
>
> Since we seem to have support for fragments now with kvm and friends,
> having this does not seem to be a big stretch though.
Yes, that is why I proposed place it in a common location.
>
>>
>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>   kernel/configs/be.config |  1 +
>>   kernel/configs/le.config |  1 +
>>   scripts/kconfig/Makefile | 10 ++++++++++
>>   3 files changed, 12 insertions(+)
>>   create mode 100644 kernel/configs/be.config
>>   create mode 100644 kernel/configs/le.config
>>
>> diff --git a/kernel/configs/be.config b/kernel/configs/be.config
>> new file mode 100644
>> index 0000000..c5cdc99
>> --- /dev/null
>> +++ b/kernel/configs/be.config
>> @@ -0,0 +1 @@
>> +CONFIG_CPU_BIG_ENDIAN=y
>> diff --git a/kernel/configs/le.config b/kernel/configs/le.config
>> new file mode 100644
>> index 0000000..be479cf
>> --- /dev/null
>> +++ b/kernel/configs/le.config
>> @@ -0,0 +1 @@
>> +# CONFIG_CPU_BIG_ENDIAN is not set
>> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
>> index d79cba4..2e8007e 100644
>> --- a/scripts/kconfig/Makefile
>> +++ b/scripts/kconfig/Makefile
>> @@ -126,6 +126,14 @@ PHONY += tinyconfig
>>   tinyconfig:
>>   	$(Q)$(MAKE) -f $(srctree)/Makefile allnoconfig tiny.config
>>
>> +PHONY += beconfig
>> +beconfig: be.config
>> +	@:
>> +
>> +PHONY += leconfig
>> +leconfig: le.config
>> +	@:
>> +
>>   # Help text used by make help
>>   help:
>>   	@echo  '  config	  - Update current config utilising a line-oriented program'
>> @@ -151,6 +159,8 @@ help:
>>   	@echo  '  kvmconfig	  - Enable additional options for kvm guest kernel support'
>>   	@echo  '  xenconfig       - Enable additional options for xen dom0 and guest kernel support'
>>   	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
>> +	@echo  '  beconfig	  - Update current config to use big endian CPU'
>> +	@echo  '  leconfig	  - Update current config to use little endian CPU'
>>
>>   # lxdialog stuff
>>   check-lxdialog  := $(srctree)/$(src)/lxdialog/check-lxdialog.sh
>>
>
>
