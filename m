From: slash.tmp@free.fr (Mason)
Date: Thu, 9 Jun 2016 09:53:14 +0200
Subject: [PATCH] cpufreq: mvebu: fix integer to pointer cast
In-Reply-To: <32804824.nq0AOIbNnC@wuerfel>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
 <5757CF9B.3080402@free.fr>
 <d3c117ea-2dce-63a2-7888-31ee8320a3dd@codethink.co.uk>
 <32804824.nq0AOIbNnC@wuerfel>
Message-ID: <5759206A.3020105@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2016 09:07, Arnd Bergmann wrote:
> On Wednesday, June 8, 2016 9:59:26 AM CEST Ben Dooks wrote:
>> On 08/06/16 08:56, Mason wrote:
>>> On 07/06/2016 13:30, Ben Dooks wrote:
>>>
>>>> Fix the use of 0 instead of NULL to clk_get() call. This stops the
>>>> following warning:
>>>>
>>>> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
>>>
>>> May I ask which compiler/version produced that diagnostic?
>>
>> I was running with "make C=2 bzImage" for ARM multi_v7_config
>>
>> $ sparse --version
>> v0.5.0

Ben, in my nitpicker's opinion, your patch subject is not
quite correct. There is, obviously, no cast in the statement
clk = clk_get(cpu_dev, 0);

There is, however, an implicit conversion (as if by assignment)
which converts the second argument (a null pointer constant) to
an actual null pointer.

I can't find a better wording than
"Use NULL instead of unadorned 0 for null pointer constants"
or
"Use NULL explicitly for pointer arguments"

As a funky side note, any constant expression with the value 0
is a valid null pointer constant. Thus the expression 42/666
is a valid equivalent to NULL ;-) Another one of C's historic warts.

> I believe gcc-6 will also produce a similar warning when building with
> 'make W=1'.

Probably not.

  https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

-Wzero-as-null-pointer-constant (C++ and Objective-C++ only)
    Warn when a literal '0' is used as null pointer constant.
    This can be useful to facilitate the conversion to nullptr in C++11.

$ cat test.c 
extern void foo(void *p);
void bar(void) {
	foo(0);
}

$ gcc-6 -Wall -Wextra -c test.c 
/* NO WARNING */

$ gcc-6 -Wall -Wextra -Wzero-as-null-pointer-constant -c test.c 
cc1: warning: command line option '-Wzero-as-null-pointer-constant' is valid for C++/ObjC++ but not for C

Regards.
