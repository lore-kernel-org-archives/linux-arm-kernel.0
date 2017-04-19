From: sramana@codeaurora.org (Srinivas Ramana)
Date: Wed, 19 Apr 2017 18:20:10 +0530
Subject: LDM/STM alignment fixups on arm64
In-Reply-To: <20170419095830.GK17774@n2100.armlinux.org.uk>
References: <58F704D6.6000301@codeaurora.org>
 <20170419095830.GK17774@n2100.armlinux.org.uk>
Message-ID: <58F75D02.1030104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2017 03:28 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 19, 2017 at 12:03:58PM +0530, Srinivas Ramana wrote:
>> Hi,
>>
>> While understanding how the alignment are handled on arm and arm64, we came
>> across the fixups for LDM/LDRD/STM on arm where as these fixups are not
>> present on arm64.
>>
>> There may be some specific reason why these fixups are not ported to arm64.
>> Can you please help us understand this?
>>
>> With this difference in how kernel handles 32-bit apps on arm and arm64,
>> there can be apps which are working without abort on arm, but fail on arm64
>> (SIGBUS). We have tried to get some history on web, but not successful.
>>
>> If this is indeed missing on arm64, do you see any issue if its ported (does
>> it fail any guidance)?
>
> Do you have an application that fails because of this?  Your email makes
> it sound very theoretical.
>

I don't have any application with me right now. But i just tried passing 
an intentional misaligned address in a test program. When i say 
intentional, please note this code is buggy and should be fixed.

So, my question is when arm has such fixups to handle such cases and do 
gracefully, is there any reason why those fixups are not ported to 
arm64? Again, I do agree that apps has to fix these instances, but we do 
have fixups in arch/arm.

I do see that the compiler can detect (if its not intentionally induced) 
such cases and avoiding to generate LDM/STM and generates multiple 
LDR/STR. So, I just want to know if it is safe to assume that the 
compiler would take care of all such misaligned addresses passed to LDM/STM?

------------------------>8---------------------------------------
struct locat {
         int a;
         int b;
         int c;
         int d;
};

int test_func()
{
         struct locat *int_pool1;
         struct locat int_pool2;
         struct locat *int_pool3;
         char *ptr;

         int_pool1 = malloc(sizeof(struct locat) + 16);
         ptr = (char *)int_pool1;
         int_pool3 = (struct locat *)(ptr+1);

         printf("pool1 addr: 0x%08x pool3 addr: 0x%08x \n", &int_pool1, 
int_pool3);
         int_pool2 = *int_pool3;
}

------------------------8<---------------------------------------


Thanks,
-- Srinivas R


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
