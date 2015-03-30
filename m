From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Mar 2015 16:05:52 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <55196228.5050805@arm.com>
References: <55071742.6000405@arm.com>
 <20150316181634.GK8656@n2100.arm.linux.org.uk>
 <55072BF5.7030901@arm.com>
 <20150316195255.GM8656@n2100.arm.linux.org.uk>
 <550818A6.9020205@arm.com>
 <20150317153657.GY8656@n2100.arm.linux.org.uk>
 <55084D99.7050004@arm.com>
 <20150317161748.GZ8656@n2100.arm.linux.org.uk>
 <20150330140333.GJ24899@n2100.arm.linux.org.uk>
 <55196228.5050805@arm.com>
Message-ID: <20150330150552.GK24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 03:48:08PM +0100, Sudeep Holla wrote:
> Though <2 2 1> works fine most of the time, I did try testing continuous
> reboot overnight and it failed. I kept increasing the latencies and
> found out that even max latency of <8 8 8> could not survive continuous
> overnight reboot test and it fails with exact same issue.
> 
> So I am not sure if we can consider it as a fix. However if we are OK to
> have *mostly reliable*, then we can push that change.

Okay, the issue I have is this.

Versatile Express used to boot reliably in the nightly build tests prior
to DT.  In that mode, we never configured the latency values.

Then the legacy code was removed, and I had to switch over to DT booting,
and shortly after I noticed that the platform was now randomly failing
its nightly boot tests.

Maybe we should revert the commit removing the superior legacy code,
because that seems to be the only thing that was reliable?  Maybe it was
premature to remove it until DT had proven itself?

On the other hand, if the legacy code hadn't been removed, I probably
would never have tested it - but then, from what I hear, this was a
*known* issue prior to the removal of the legacy code.  Given that the
legacy code worked totally fine, it's utterly idiotic to me to have
removed the working legacy code when DT is soo unstable.

Whatever way I look at this, this problem _is_ a _regression_, and we
can't sit around and hope it magically vanishes by some means.

I think given what you've said, it suggests that there is something else
going on.  So, what we need to do is to revert the removal of the legacy
code and investigate what the differences are between the apparently
broken DT code and the working legacy code.

I have not _once_ seen this behaviour with the legacy code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
