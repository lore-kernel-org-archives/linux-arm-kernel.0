From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 5 Mar 2011 10:32:18 +0000
Subject: [PATCH v2 2/2] ARM: Enable TS-78XX features in unknown revisions
Message-ID: <bbf948-iel.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In gmane.linux.kernel Michael Spang <mspang@csclub.uwaterloo.ca> wrote:
>
> When the manufacturer increases the revision number the platform
> devices for the RTC, NAND, and RNG disappear. We should assume
> new revisions have these devices instead of assuming they do not.
>
NACK

This would break things for anyone running a custom FPGA bitstream (and 
they are out there) .  The RTC and RNG are possibly the only things that 
are able to be implemented in a custom FPGA, the NAND is wholly TS 
specific..

Please could you refrain submitting patches for TS-7800 without having 
a quick look at:
 * http://git.kernel.org/?p=linux/kernel/git/nico/orion.git
 * http://www.digriz.org.uk/ts78xx/kernel

The former is pretty much what you have to base all your patches on so 
you should be tracking it (which would have solved the re-inventing the 
revision update patch), whilst the latter would help tell you things 
that have already been done elsewhere.

The latter site also includes thoughts on where the platform code is 
going.  So far as *zero* people have ever provided feedback or thoughts 
(unfortunately they seem too busy just bluntly hammering things in the 
ts7000 forum) I have so far to date only done things that I feel are 
most appropriate.  This includes things like the doorbell code necessary 
to get IRQ's firing from the PC/104 bus...which I hope no-one is wasting 
their time re-implementing?

This is not a case of megalomania, it's a case of saving wasted effort, 
testing patches and getting obtaining code review.

I can see the value in this particular patch, but problems with it could 
have trivially been avoided by reworking the FPGA ID code so that the 
RTC/NAND/RNG are only enabled when the *magic* is set to 0x00b480; then 
we should remove the all the 'case TS7800_REV_1..9' bits.  I'll put this 
together and push it to Nico, reverting your efforts... :-/

Cheers

[1] http://git.wormnet.eu/?p=alex/ts78xx.git;a=commitdiff;h=de3a91588ccc5f9443f0e0a1656a94c6ddb19bdb

-- 
Alexander Clouter
.sigmonster says: It's not the fall that kills you, it's the landing.
