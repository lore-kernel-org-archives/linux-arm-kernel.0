From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 22 Nov 2015 21:36:45 -0500 (EST)
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <4527012.vmieWOaE32@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <6840047.0HF9qAEq6r@wuerfel> <20151122194704.GJ8644@n2100.arm.linux.org.uk>
 <4527012.vmieWOaE32@wuerfel>
Message-ID: <alpine.LFD.2.20.1511222111020.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 22 Nov 2015, Arnd Bergmann wrote:

> I've also found some /proc/cpuinfo output to cross-reference SoCs
> to their core names.
> 
> 		variant	part	revision	name		features
> dove:		0	0x581	5		PJ4		idivt

I just managed to boot my dusty Dove DB and ran a quick test programon 
it. Its cpuinfo corresponds to the above.

$ cat m.c
#include <stdio.h>
int mydiv(int, int);
int main()
{
        printf("div test\n");
        printf("%d\n", mydiv(12345678, 37));
        return 0;
}
$ cat d.c
int mydiv(int x, int y)
{
        return x/y;
}
$ gcc -o test m.c d.c
$ ./test
div test
333666
$ gcc -o test m.c d.c -march=armv7ve -mthumb
$ ./test
div test
333666
$ gcc -o test m.c d.c -march=armv7ve -marm
$ ./test
div test
Illegal instruction (core dumped)
$


Nicolas
