From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jul 2015 19:14:40 +0100
Subject: [PATCH v3 6/6] arm64: kernel: Add support for Privileged Access
 Never
In-Reply-To: <55AFDB46.3060302@arm.com>
References: <1437481411-1595-1-git-send-email-james.morse@arm.com>
 <1437481411-1595-7-git-send-email-james.morse@arm.com>
 <20150721123830.GD25887@localhost> <20150722170140.GR6650@arm.com>
 <55AFDB46.3060302@arm.com>
Message-ID: <20150722181440.GS6650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 07:04:54PM +0100, James Morse wrote:
> On 22/07/15 18:01, Will Deacon wrote:
> > I've applied your series with the exception of this last one, as it
> > conflicts with some other patches I have queued for 4.3. Please can you
> > rebase this against the arm64 "devel" branch? (usually it would be
> > for-next/core, but I'm holding off stabilising until -rc4 since allmodconfig
> > build is broken atm).
> 
> The version of patch 5 "arm64: kernel: Add optional CONFIG_ parameter to
> ALTERNATIVE()" in your tree has:
> 
> > [will: removed unused asm macro changes for now to avoid conflicts]
> 
> Those were used in arch/arm64/lib/clear_user.S and friends.
> I shall remove the 'CONFIG_ARM64_PAN' from those four asm files - it can be
> tidied up later.

Ah, damn, I didn't realise you'd made the ALTERNATIVE macro work for both
C and asm. The reason I changed it is because I don't know what's best to
do with the new alternative_if_not macros -- having an enabled argument
for the _else and _endif variants is really odd.

I think the options are:

  (1) Just spit out a NOP (you're current approach)
  (2) Use #ifdefs at the caller
  (3) Only have the option for alternative_insn
  (4) Add the option to all the alternative_ macros

What do you reckon?

Will
