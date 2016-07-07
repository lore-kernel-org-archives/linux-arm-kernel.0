From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 7 Jul 2016 09:39:32 +0200
Subject: [GIT PULL] STi DT updates for v4.8
In-Reply-To: <20160707052827.GL32389@localhost>
References: <5776701A.1000808@st.com> <20160707052827.GL32389@localhost>
Message-ID: <577E0734.2070206@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

On 07/07/2016 07:28 AM, Olof Johansson wrote:
> Hi Patrice,
>
>
> On Fri, Jul 01, 2016 at 03:28:58PM +0200, Patrice Chotard wrote:
>> Hi Olof, Arnd and Kevin,
>>
>> Please consider this first round of STi DT updates for v4.8:
>>
>> The following changes since commit 6ca59e6e1fc3a8d7ccbf85ff036bd6ff40847c1a:
>>
>>    clk: st: clkgen-pll: Detect critical clocks (2016-06-30 12:17:11 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
>> sti-dt-for-v4.8
> This specifies a branch, not a tag.

Right, i will push the tag sti-dt-for-v4.8
>
>> for you to fetch changes up to 4543976eaf9ca9f379ac3a0bb8c5c8c84fe0a965:
>>
>>    spi: st-ssc4: Remove 'no clocking' hack (2016-07-01 11:58:10 +0200)
>>
>> ----------------------------------------------------------------
>> Highlights:
>> -----------
>>   -add STi critical clocks
>> - as discussed on IRC with Lee Jones, remove SPI hack wich has dependecy
>> with critical clocks
>>
>> ----------------------------------------------------------------
>> Lee Jones (3):
>>        ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
>>        ARM: sti: stih410-clocks: Identify critical clocks
>>        spi: st-ssc4: Remove 'no clocking' hack
> THere are more patches than this in this branch -- there are three clock
> branches that by the look of it have been applied by Stephen Boyd.
>
> However, since they have been brought in without doing a merge, it's hard for
> us to tell where they came form, and/or if they're in a shared branch
> somewhere. Therefore, I recommend doing a --no-ff merge of the branch, so it's
> obvious from the merge commit where they came form. They also need to be part
> of the diffstat.
>
> Finally, the clk patch doesn't really belong in the DT branch here. It's
> probably a suitable patch to send to the clk maintainers after the DT changes
> have gone in, i.e. for 4.9.
>
> Please respin this pull request and we'll take another look!

There was a discussion on IRC armlinux's channel between Lee Jones, Arnd 
Bergman
and Mark Brown about the way to proceed with this pull request.

As there are dependencies between the 3 critical clocks patches on 
Stephen Boyd's
branch clk-next/clk-st-critical, our STi DT and our SPI drivers which 
remove a temporary
clock hack, the decision was taken to put our DT STi fixes on top of 
Stephen Boyd critical clk
  branch and our SPI patches on the top.

For more details i put in attachment the IRC exchange about this.

Patrice





>
>
> Thanks,
>
> -Olof

-------------- next part --------------
<lag> arnd: ojn: khilman: Morning chaps.  Just wanted to clear something with you before wasting the STi Maintainer's time
<lag> arnd: ojn: khilman: We have a set for identifying Critical Clocks -- the core API and STi changes have now been merged
<lag> arnd: ojn: khilman: I've written an anti-hack for SPI, which we've now obtained an Ack for
* weox (uid112413 at gateway/web/irccloud.com/x-hsqquvsjfapqgsde) has joined #armlinux
<lag> arnd: ojn: khilman: The sboyd has kindly supplied an immutable branch for the STi Maintainer to base his ARM-SoC DT PR on
<lag> arnd: ojn: khilman: As you know, this is how we usually work over multiple subsystems
<lag> arnd: ojn: khilman: Are you guys happy to work like this too?
* liuyq (~liuyq at 85.203.21.78) has joined #armlinux
<lag> arnd: ojn: khilman: To clarify, is it okay for pchotard's STi DT ARM-SoC PR to be based on sboyd's immutable branch and contain the SPI patch?
<arnd> lag: can you clarify what the dependency is? I assume it's ok, but we should only do this if it can't be avoided
<lag> arnd: If the SPI patch lands in Mainline first, it will break SPI on our platform
<lag> arnd: The alternative is to push the SPI patch via broonie during -rc1
<lag> arnd: But this kinda breaks convention
<arnd> lag: so the reason is that you are breaking both backward and forward compatibility with old DTs?
<arnd> lag: if that is the case, what is the reason the spi driver can't cope with old DT?
<lag> arnd: The only reason it copes currently is a) we have clk_ignore_unused (cmd line arg) enable and b) it contains a hack: drivers/spi/spi-st-ssc4.c lines 79 & 92
<lag> arnd: The SPI change I'm speaking about removes the hack
<lag> arnd: ST do not use unmatching DTB files
<lag> arnd: It's a ridiculousness we've adopted from Enterprise for some reason!
<arnd> lag: so could we just defer the spi patch to the next merge window? it doesn't seem urgent at all, though it's clearly the right thing to do
<arnd> we try to not have any changes in next/dt besides dts files and bindinds
<lag> arnd: That means SPI will remain broken for another version, which I'd like to avoid
<arnd> ok, maybe we can put the spi change into a next/late branch then
<arnd> I don't know if ojn has already started one
<lag> arnd: Then I suggest the alternative and push the SPI patch through the -rcs
<lag> arnd: Holding it back an entire kernel version isn't reasonable
<arnd> the next/late branch is what we commonly use for this kind of dependency
<lag> arnd: Sounds good
<lag> pH5: You around?
<lag> pH5: 4aa34ce :)
<arnd> does the dt branch still require the dependency on clk branch, or do we just need the spi patch on top of both the dt and the clk branches?
<lag> arnd: Needs to be on top of both
<lag> arnd: But that should be handled, depending on when sboyd sends his set
<lag> arnd: He has an immutable branch which only contains 3 patches, if that's of use
<arnd> so our next/late branch just depends on clk, but next/dt doesn't?
<lag> arnd: The SPI patch depends on them both landing
<lag> arnd: ... before it does
<lag> arnd: If broonie will be kind enough to take it into his SPI -fixes branch, that would solve all of this
<broonie> I don't know what patch you lot are talking about here...
<broonie> But why not just merge all three bits via the same path with the dependencies sorted out in git?
<pH5> lag: hi, sorry I didn't realize your fixes also depended on the shared+optional api patch, at first.
<arnd> that would work too. lag, can you easily separate out the dt changes for this thing from the other dt changes? then the three clk changes, the respective dt changes  and the bugfix can all go into arm-soc/next/late together
<lag> broonie: That's what I suggested to start with
<lag> pH5: Ya!  But I explained that to Linus and he accepted anyway, so all good :)
<lag> pH5: Thanks for your help
<lag> arnd: That works for me too
<lag> pchotard: Are you happy do to that?
<lag> pchotard: I can help you create that branch, then it just needs submitting separate from the 3 you already know about
<lag> pchotard: The alternative is, you provide me with Acks for the DT changes and I can submit the PR to ARM-SoC
<redengin> anyone know where I can find a cortex-r linux start?
<pchotard> lag: so if i have well all understood, i will submit the critical DT changes on top of clk-next/clk-st-critical branch from sboyd , right ?
<pchotard> lag: and then the SPI hack ?
<lag> pchotard: Correct
<lag> pchotard: As well as the Critical Clock DT changes
<lag> pchotard: So now you have; dt, defconfig, machine and late
<lag> pchotard: These will go into your 'late' PR
<pchotard> lag: to sum up, i still need to do separate PR ? one for DT, one for defconfig, one for machine ?
<pchotard> lag: what is the content of the late PR ? only the spi hack patch ?
* ming_lei (~ming at 183.37.224.163) has joined #armlinux
<lag> pchotard: The 'late' PR needs to be based on sboyd's immutable branch and contain the Critical Clock DT changes and the SPI patch needs to be on the top
<lag> pchotard:       | /drivers/clk/sti/ | STi DT | SPI |
<pchotard> lag: ok , that what i initially understood, but your exchange with arnd confused me, my english need improvements ;-)
