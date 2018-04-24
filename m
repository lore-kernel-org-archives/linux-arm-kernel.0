From: k.marinushkin@gmail.com (Kirill Marinushkin)
Date: Tue, 24 Apr 2018 02:35:50 +0200
Subject: [PATCH] staging: bcm2835-audio: Disconnect and free vchi_instance
 on module_exit()
In-Reply-To: <20180423135024.GA2337@kroah.com>
References: <20180417050028.19372-1-k.marinushkin@gmail.com>
 <20180423135024.GA2337@kroah.com>
Message-ID: <7e2dbb73-f93d-7b87-2fa0-d8b40f4a11a5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/18 15:50, Greg Kroah-Hartman wrote:
> On Tue, Apr 17, 2018 at 07:00:28AM +0200, Kirill Marinushkin wrote:
>> In the current implementation, vchi_instance is inited during the first
>> call of bcm2835_audio_open_connection(), and is never freed. It causes a
>> memory leak when the module `snd_bcm2835` is removed.
>>
>> Here is how this commit fixes it:
>>
>> * the VCHI context (including vchi_instance) is created once in the
>>   platform's devres
>> * the VCHI context is allocated and connected once during module_init()
>> * all created bcm2835_chips have a pointer to this VCHI context
>> * bcm2835_audio_open_connection() can access the VCHI context through the
>>   associated bcm2835_chip
>> * the VCHI context is disconnected and freed once during module_exit()
>>
>> After this commit is applied, I don't see other issues with the module's
>> init/exit, so I also remove the associated TODO task.
>>
>> Steps to reproduce the memory leak before this commit:
> <snip>
>
> Patch dropped due to kbuild complaints.
>
> Please fix up and resend.
>
> thanks,
>
> greg k-h

Hello Greg,

Due to which complains of kbuild is the patch dropped?
I would like to fix the complains, but I don't see any errors or warnings on my
side.
Are you sure that the kbuild test robot did it's job correctly? The log says:

>> it may well be a FALSE warning

Please show me what is wrong in my patch.

The log from kbuild test robot says:

>> [auto build test WARNING on staging/staging-testing]
>> [also build test WARNING on v4.17-rc1]
>> [cannot apply to anholt/for-next]
>> [if your patch is applied to the wrong git tree, please drop us a note to
help improve the system]
>>
>> url:
https://github.com/0day-ci/linux/commits/Kirill-Marinushkin/staging-bcm2835-audio-Disconnect-and-free-vchi_instance-on-module_exit/20180417-193147
>> config: arm-allmodconfig
>> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>> wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
-O ~/bin/make.cross
>> chmod +x ~/bin/make.cross
>> make.cross ARCH=arm allmodconfig
>> make.cross ARCH=arm
>>
>> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
>> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

I cannot clone from the given url, because it does not exist.
I cannot use the compiler from the log, because it is built for x86_64, and my
host machine is i686.
Below are the steps how I tried to reproduce the issue, but errors or warnings
didn't happen.

I applied the patch on top of the following upstream tag:
60cc43fc8884 (tag: v4.17-rc1) Linux 4.17-rc1

And executed:
make CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 ARCH=arm allmodconfig
make CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 ARCH=arm

But the compilation succeed without any errors or warnings.

My compiler version is:
arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.8-2014.01 - Linaro GCC
2013.11) 4.8.3 20140106 (prerelease)

Best Regards,
Kirill
