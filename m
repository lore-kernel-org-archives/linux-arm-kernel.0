From: h.huangqiang@huawei.com (Qiang Huang)
Date: Wed, 17 Dec 2014 18:58:30 -0800
Subject: [PATCH boot-wrapper-aarch64] configure: Fix for --with-initrd=no
In-Reply-To: <20141217114602.GA8942@leverpostej>
References: <5490EADF.7080906@huawei.com> <20141217114602.GA8942@leverpostej>
Message-ID: <549242D6.5050106@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/12/17 3:46, Mark Rutland wrote:
> On Wed, Dec 17, 2014 at 02:30:55AM +0000, Qiang Huang wrote:
>> Our configure.ac script wasn't handle --with-initrd=no, when this was passed,
>> we got error:
> 
> The parameter to --with-initrd should be the name of the initrd to use;
> "yes" or "no" are not valid parameters. I note that the help text is
> misleading in this regard, it should probably be fixed up to say
> something like "Specify an initrd to use". 

Yeah, sorry I didn't see the help message, I just thought this should
be the standard way.

According to autoconf's man page:
https://www.gnu.org/software/autoconf/manual/autoconf-2.65/html_node/External-Software.html

All packages should support --with-package=no and --with-package=yes
and --without-package, these should be the standard usage right?
Seems if we follow these usage, lots of entries needs to be modified,
so maybe we can just leave them as they were?

> 
> While it's unlikely that someone will have an initrd called "no", this
> issue can only occur with incorrect usage of the bootwrapper configure
> script. I'd happily accept a patch fixing up the help text, though.
> 
> Thanks,
> Mark.
> 
>> ...
>> aarch64-linux-gnu-ld -o linux-system.axf --script=model.lds
>> aarch64-linux-gnu-ld: cannot find no
>> make: *** [linux-system.axf] Error 1
>>
>> Fix this by adding a line to check this.
>> And this also fixed --without-initrd.
>>
>> Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
>> Cc: Geoff Levand <geoff@infradead.org>
>> ---
>>  configure.ac | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 929da13..553013b 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -58,6 +58,7 @@ AC_SUBST([CPU_IDS], [$C_CPU_IDS])
>>  AC_ARG_WITH([initrd],
>>  	AS_HELP_STRING([--with-initrd], [embed an initrd in the kernel image]),
>>  	USE_INITRD=$withval)
>> +AS_IF([test "x$USE_INITRD" = "xno"], [USE_INITRD=], [])
>>  AC_SUBST([FILESYSTEM], [$USE_INITRD])
>>  AM_CONDITIONAL([INITRD], [test "x$USE_INITRD" != "x"])
>>
>> -- 
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> .
> 
