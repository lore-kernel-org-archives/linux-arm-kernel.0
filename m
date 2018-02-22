From: stefan@the2masters.de (Stefan Hellermann)
Date: Fri, 23 Feb 2018 00:18:11 +0100
Subject: [v2,1/1] ARM: orion5x: use mac_pton() helper
In-Reply-To: <20180222214237.GH28112@lunn.ch>
References: <1443795153-40836-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <099870d3-e2bd-aad9-d526-5438596bb575@the2masters.de>
 <20180222214237.GH28112@lunn.ch>
Message-ID: <bce65520-7f11-49f5-c806-59e508001321@the2masters.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.02.2018 um 22:42 schrieb Andrew Lunn:
> On Thu, Feb 22, 2018 at 06:45:51PM +0100, Stefan Hellermann wrote:
>> Hi!
>>
>> My QNAP TS-209 NAS Device is crashing with the following commit, which went
>> in the kernel as commit 4904dbda41c860fd117b20f3c48adb2780eee37e
>>
>> I cannot provide a boot log, the device panics before enabling the serial
>> console.
> Hi Stefan
>
> Did you try earlyprintk? You might need to recompile your kernel to
> enable it.
Yes, I tried it, but it didn't help. I even changed qnap_ts209_init() to 
configure uart before ethernet, but it didn't help either.
>
> Looking at the code, i don't see anything obviously wrong. So i think
> i would start by looking how many times it goes through the loop in
> qnap_tsx09_find_mac_addr() with this patch reverted, and what address
> it finds the MAC address at.
>
> Then see what happens with the current crashing code. Is it failing to
> recognise the MAC address, and so keep looping around?
I think I found the failure:
The code is looping through an ext2 filesystem on a 384kB mtd partition 
(factory configuration put there by QNAP). There it looks on every 1kB 
boundary if there is a valid MAC address. The filesystem has a 1kB block 
size, so this seems to work. The MAC address is on the 37th 1kB block.

But: On the 27th block is a large file (1,5kB) without 0 bytes inside.
The code in qnap_tsx09_find_mac_addr() maps 1kB into memory (not a whole 
file or the whole 384kB) and then calls qnap_tsx09_check_mac_addr() -> 
mac_pton() -> strlen() on this memory block. as there is no 0 byte in 
the file on the 27th block, strlen runs into bad memory and the machine 
panics. The old code had no strlen().

I changed mac_pton() to use strnlen(), and now the panic is gone. I 
don't know why strlen is actually needed in mac_pton. The string is 
checked in the following loop, if there is a zero byte somewhere, the 
loop will be returned immediately. So I think the strlen() superfluous. 
Is the following patch correct?

diff --git a/lib/net_utils.c b/lib/net_utils.c
index 148fc6e99ef6..e7785cf20f59 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -7,10 +7,6 @@ bool mac_pton(const char *s, u8 *mac)
 ?{
 ???? int i;

-??? /* XX:XX:XX:XX:XX:XX */
-??? if (strlen(s) < 3 * ETH_ALEN - 1)
-??? ??? return false;
-
 ???? /* Don't dirty result unless string is valid MAC. */
 ???? for (i = 0; i < ETH_ALEN; i++) {
 ???? ??? if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
