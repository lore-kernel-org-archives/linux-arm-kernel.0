From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 31 Oct 2012 17:11:23 -0400
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <87fw4u3oh5.fsf@deeprootsystems.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
 <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
 <20121030123254.GD29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
 <20121030125419.GG29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
 <CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
 <87fw4u3oh5.fsf@deeprootsystems.com>
Message-ID: <CAORVsuUWD3gHh1NcMLeGwZ=hF=UiOG2VyJkADZNcGVr1g1TFgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Oct 31, 2012 at 6:49 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Jean,
>
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
> [...]
>
>>> Based on a very quick look, I'd say the original patch 3db11fe is broken.
>>> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is
>>> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for
>>> omap2plus_defconfig.
>>
>> Withtout CPU_IDLE set the PM QoS has no influence on the power domains states.
>
> Exactly, which means there is *no* constraint set when CPUidle is
> disabled,
Correct. With CPU_IDLE disabled PM QoS manages the constraints list
but cpuidle does not request the aggregated value nor does it restrict
the CPU and CORE power domains states.

> and it's exactly this that is different from the behavior
> before your patch.
No.

> Before your patch, the constraint would be set whether or not CPUidle
> was enabled, correct?
No. In the linux-omap source tree the OMAP PM API for the latency
constraints simply is a no-op. The only difference with the code after
the patch is that PM QoS manages the constraints list, which should be
neglictable in terms of CPU execution time.

Paul,
Could you please check with the 2 calls to PM QoS from the I2C code
commented out? This will rule out the PM QoS impact.

> The solution to this will probably be to make OMAPs non-CPUidle idle path
> check the constraints.
This is the idea behind the per-device PM QoS support, which allows to
set a constraint on any device and so on any power domain (note that
cpuidle influences CPU and CORE only).
However in the current context -the I2C timeouts issue- there is no
apparent link between the issue and the patch 3db11fef [1].

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=3db11feffc1ad2ab9dea27789e6b5b3032827adc

> Kevin

Thanks,
Jean
