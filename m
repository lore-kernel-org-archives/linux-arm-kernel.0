From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Aug 2015 15:37:03 +0100
Subject: [PATCHv5 0/5] arm/arm64: Unify PSCI client support
In-Reply-To: <1438353980-7611-1-git-send-email-mark.rutland@arm.com>
References: <1438353980-7611-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20150803143703.GH10501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, Jul 31, 2015 at 03:46:15PM +0100, Mark Rutland wrote:
> This series unifies the 32-bit and 64-bit PSCI client code, moving the bulk of
> the FW invocation and probing out to a common location in drivers/firmware. The
> bulk of the PSCI 0.2 cleanups have hit mainline now, so this is just the
> unification portion.
> 
> This results in a reasonable saving in terms of lines of code, and will allow
> for PSCI 1.0 support to be unified form the beginning, avoiding further
> duplication.
> 
> Since v4 [1]:
> * Apply Rob Herring's ack
> * Rebase to v4.2-rc2 to handle a trivial conflict
> * Reorder the series to keep arch/arm patches together
> Since v3 [2]:
> * Drop the PSCI 0.2 patches as they're in mainline
> * s/__pa/virt_to_idmap/ from Grygorii Strashko
> * Use macros for Calxeda CPU_SUSPEND parameters
> 
> Russell, are you happy with the arch/arm patches? If so, are you happy for them
> to go via another tree, or would you prefer that I set up a stable branch for
> merging?
> 
> I was under the impression that you had already taken Grygorii's patch but I
> couldn't spot it in any branches. I can drop that if you already have it.

I've been looking at merging this, but it's a tad fiddly touching all of
arm, arm64 and drivers. One way to do it would be:

  (1) I create a branch containing patches 1,2 and 5 based on -rc2 and
      merge that into the arm64/for-next/core branch. There's a minor
      conflict, but it's easy to resolve.

  (2) I create another branch, which is just the branch merged in (1) +
      patches 3 and 4 on top. I send a pull request for that to rmk.

  (3) Torvalds will get the minor conflict resolved in (1) when he merges
      the arm and arm64 trees.

If we're not comfortable with (3), then the whole lot could go via
arm-soc instead (including the conflict resolution).

Russell, Olof, any preferences?

Will
