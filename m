From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 10 Feb 2015 17:36:20 +0800
Subject: arm: kprobe compilation error
In-Reply-To: <54D9C121.3000601@huawei.com>
References: <54D38982.6000100@elproma.com.pl>
 <1423475079.2864.49.camel@linaro.org> <54D8934B.6040709@elproma.com.pl>
 <54D9C121.3000601@huawei.com>
Message-ID: <54D9D114.5000002@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/10 16:28, Wang Nan wrote:
> On 2015/2/9 19:00, Janusz U?ycki wrote:
>>
>> W dniu 2015-02-09 o 10:44, Jon Medhurst (Tixy) pisze:
>>> Hi Janusz
>>>
>>> On Thu, 2015-02-05 at 16:17 +0100, Janusz U?ycki wrote:
>>>> I got the compilation error on next-20150204:
>>>>
>>> [...]
>>>> In file included from arch/arm/probes/kprobes/core.c:37:
>>>> arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other
>>>> than a declaration
>>> [...]
>>>> gcc version 4.2.4
>>> Thanks for reporting this, is it OK if I add to a patch to fix this a
>>> line saying "Reported-by: Janusz U?ycki <j.uzycki@elproma.com.pl>"?
>>
>> sure
>>
>>>
>>> Whilst the extra '*' looks like an obvious typo, it's interesting that
>>> your error message implies that it's allowed in some situations and that
>>> the version of GCC that I use (4.9.1) doesn't complain about it.
>>> If it's valid C, I've no idea what that syntax that might represent.
>>>
>> I've not find such extension in C11 but likely gcc's team knows the answer.
>> It also compiles using gcc 4.8.3. However I thing more people use older compilers
>> for different platforms.
>>
> 
> Hi All,
> 
> Thanks for reporting and fixing this.
> 
> When writing this code I checked C spec from open-std (n1548 and n1570). I got an
> feeling that [*] should be a standard way to specify variable length array types.
> Please see 6.7.6.3 and 6.7.7 of the spec. However I forgot there are old gccs which
> don't support that standard.
> 
> Thank you!
> 

I did a boring searching and found some useful information:

The '[*]' syntax was introduced at 1997 as part of variable length array (VLA) support:

http://www.open-std.org/JTC1/SC22/WG14/www/docs/n683.htm

so it is not a new extension. However, according to 6.7.6.2 of the spec:

   If the size is not present, the array type is an incomplete type. If the size is * instead of
   being an expression, the array type is a variable length array type of unspecified size,
   ...
   (Variable length arrays are a conditional feature that implementations need not support; see 6.10.8.3.)

and 6.10.8.3 provides a macro:

   __STDC_NO_VLA__ The integer constant 1, intended to indicate that the
       implementation does not support variable length arrays or variably
       modified types.

In our situation what we need is an incomplete type of array, so Tixy's fix is correct.
It's my fault to incorrectly use VLA.

Thank you.

>> best regards
>> Janusz
>>
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
