From: greg@kroah.com (Greg KH)
Date: Thu, 13 Sep 2018 14:40:46 +0200
Subject: [stable PATCH 1/2] arm64: Fix mismatched cache line size detection
In-Reply-To: <20180913121951.GE2268@kroah.com>
References: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
 <20180912193816.GF21563@kroah.com>
 <4b8db4d5-20d7-5597-7977-b8df1072ecc7@arm.com>
 <20180913121951.GE2268@kroah.com>
Message-ID: <20180913124046.GA21180@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 02:19:51PM +0200, Greg KH wrote:
> On Thu, Sep 13, 2018 at 10:54:06AM +0100, Suzuki K Poulose wrote:
> > Hi Greg,
> > 
> > On 12/09/18 20:38, Greg KH wrote:
> > > On Tue, Sep 04, 2018 at 10:10:09AM +0100, Suzuki K Poulose wrote:
> > > > commit 4c4a39dd5fe2d13e2d2fa5fceb8ef95d19fc389a upstream
> > > > 
> > > > If there is a mismatch in the I/D min line size, we must
> > > > always use the system wide safe value both in applications
> > > > and in the kernel, while performing cache operations. However,
> > > > we have been checking more bits than just the min line sizes,
> > > > which triggers false negatives. We may need to trap the user
> > > > accesses in such cases, but not necessarily patch the kernel.
> > > > 
> > > > This patch fixes the check to do the right thing as advertised.
> > > > A new capability will be added to check mismatches in other
> > > > fields and ensure we trap the CTR accesses.
> > > > 
> > > > Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
> > > > Cc: <stable@vger.kernel.org> # v4.9
> > > 
> > > Why 4.9?  be68a8aaf925 only showed up in 4.16 and was backported only to
> > > 4.14-stable.  Not to 4.9-stable from what I can tell.
> > 
> > Now when you asked this, I realise that the Fixes tags were not sufficient.
> > 
> > Actually this series fixes a bit more than the commit: be68a8aaf925 ("arm64: cpufeature:
> > Fix CTR_EL0 field definitions"). I think these patches should have :
> > 
> > Fixes: commit 116c81f427ff6c5 ("arm64: Work around systems with mismatched cache line sizes")
> > 
> > and
> > 
> > Enable trapping on mismatched bits in CTR for IDC/DIC, which were
> > added to v8.3 onwards.
> > 
> > Essentially these patches makes sure that we trap accesses to
> > CTR_EL0 when some of the fields are mismatched across CPUs, so
> > that the CPUs get a consistent view of the cache properties
> > throughout the system. It also makes sure that we put out
> > correct information about why we trap accesses to the CTR_EL0
> > accesses from the userspace.
> > 
> > Hope this helps. The same applies for the next patch.
> 
> Yes, it does help.  But these patches do not apply to the 4.14.y series,
> which I also need to apply them to (you don't want to move from 4.9.y to
> 4.14.y and get a regression.)
> 
> So can you provide backports for both of these patches for 4.14.y?  Then
> I would be glad to queue these all up.

Oh nevermind, I found those patches in my queue, you already sent them!

sorry for the noise.

greg k-h
