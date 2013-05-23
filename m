From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 23 May 2013 18:05:10 +0800
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
In-Reply-To: <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
Message-ID: <519DE9D6.8000707@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2013 05:12 PM, Geert Uytterhoeven wrote:
> On Thu, May 23, 2013 at 11:05 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> > On Thu, May 23, 2013 at 10:40:29AM +0200, Geert Uytterhoeven wrote:
>>> >> On Thu, May 23, 2013 at 9:57 AM, Chen Gang <gang.chen@asianux.com> wrote:
>>>> >> > -config BUG
>>>> >> > -       bool "BUG() support" if EXPERT
>>>> >> > -       default y
>>>> >> > -       help
>>>> >> > -          Disabling this option eliminates support for BUG and WARN, reducing
>>>> >> > -          the size of your kernel image and potentially quietly ignoring
>>>> >> > -          numerous fatal conditions. You should only consider disabling this
>>>> >> > -          option for embedded systems with no facilities for reporting errors.
>>>> >> > -          Just say Y.
>>> >>
>>> >> ... It's about reducing memory size on devices where you can't show bug or
>>> >> warning messages.
>> >
>> > And turning off CONFIG_BUG causes lots of warning messages at compile time
>> > about functions which are returning nothing which shouldn't.
>> >
>> > The problem is: trying to fix that _will_ mean the result is a larger
>> > kernel than if you just do the usual arch-implemented thing of placing
>> > an defined faulting instruction at the BUG() site - which defeats the
>> > purpose of turning off CONFIG_BUG.
> Is __builtin_unreachable() working well these days?

In fact, using __builtin_unreachable() is a standard way for
architectures to implemented their own BUG() (e.g. x86, s390, powerpc,
arm ...)

Before __builtin_unreachable(), must need an inline asm instruction
which architecture specific.

I have test using __builtin_unreachable() without an related asm
instruction before, it prints many unexpected things (please see the
attachment).

So I think, it is not suitable to use it in "asm-generic/bug.h"


Thanks.
-- 
Chen Gang

Asianux Corporation
-------------- next part --------------
#include <stdio.h>
#include <sys/types.h>
#include <error.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

int main()
{
	int file;
	int ret;
	char buf[0x100];

	file = open("/tmp/work.c", O_RDONLY);
	if (file == -1) {
		printf("\nopen file failed. errno = %d\n", errno);
		goto err;
	} else
		printf("\nopen file succeed.\n");

	printf("before unreachable\n");
	__builtin_unreachable();
	printf("after unreachable\n");

	if (lseek(file, 10, SEEK_END) < 0) {
		printf("\nlseek file failed. errno = %d\n", errno);
		goto err;
	}

	ret = read(file, buf, 0x100);
	if (ret < 0) {
		printf("\n1st read file failed. errno = %d, ret = %d\n", errno, ret);
		goto err;
	} else
		printf("\n1st read file succeed. errno = %d, ret = %d\n", errno, ret);

	ret = read(file, buf, 0x100);
	if (ret < 0) {
		printf("\n2nd read file failed. errno = %d, ret = %d\n", errno, ret);
		goto err;
	} else
		printf("\n2nd read file succeed. errno = %d, ret = %d\n", errno, ret);

	ret = read(file, buf, 0x100);
	if (ret < 0) {
		printf("\n2rd read file failed. errno = %d, ret = %d\n", errno, ret);
		goto err;
	} else
		printf("\n3rd read file succeed. errno = %d, ret = %d\n", errno, ret);


	return 0;
err:
	return -1;
}
