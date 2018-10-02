From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 2 Oct 2018 07:53:46 -0700
Subject: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
In-Reply-To: <20181002085041.GV30658@n2100.armlinux.org.uk>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
 <20181002085041.GV30658@n2100.armlinux.org.uk>
Message-ID: <7b5611cb-5bd0-d906-7013-31dbe55f8dbb@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2018 01:50 AM, Russell King - ARM Linux wrote:
> On Mon, Oct 01, 2018 at 01:44:52PM -0700, Mark Salyzyn wrote:
>> Despite the gain of 0.4% for screen-on battery life, where Android has a mix
>> of 64 and 32 bit applications, thus still relevant _today_ on 64 bit
>> architectures (providing vDSO32 for 32-bit applications).
> I don't think the issue is what you think it is.  0.4% gain is
> equivalent to almost (but not quite) 1 minute extra for a lifetime of
> 4 hours.  Is that really noticable, and is it worth the churn from
> merging this series?

Screen on battery life, all other components of the system active, 
backlights, touchscreen, sensors etc and it still had a measurable 
impact on power from the portion that came from the CPU complex. This 
impact came solely from 32 bit applications left over on the 64-bit 
platforms that did not formerly have vDSO support. 32-bit applications 
are not going away even with the advent of 64-bit (sound media framework 
on Android is 32-bit).

Reduction in power is also an increase in performance. The 
microbenchmarks show ~3-10 fold improvement in the actions of acquiring 
the time of various sorts for 32-bit applications on 64-bit. A savings 
in the range of sub-microseconds each time(sic) adds up to 0.4% battery 
improvement overall.
> Given that the gain is so marginal, I can see why people find it
> difficult to get excited about this series to spend the time reviewing
> it.
The reviews were intense over the years IMHO, appeasing several 
stakeholders and testers. Its that final ACK that has been elusive. I 
have gotten private emails from ARM many times promising some 
engineering to look at these waiting patiently without feedback.

The changes, as requested in the reviews of the past, turned also into 
moving most vdso maintenance for all architectures of ARM into lib/vdso 
with no reduction in microbenchmark performance for the other 
configurations, at least two additional non-arm architectures look like 
they could readily switch over to using it as well. This is a major win 
for maintenance (and was not part of the original set).

As a result switching 64-ARM vdso assembler to C is a win for 
maintenance if upstream'd.

Given the Android will need to place these patches in their common tree 
(not there yet because I have required upstream first, but with limits, 
2 years seems a bit long to wait for a project started in ARM, then I 
was asked to help push it forward), not having them upstream, tested, 
with many eyes on the code, will be a pity and will result in a possible 
maintenance burden on up to 13000 phone devices.

-- Mark
