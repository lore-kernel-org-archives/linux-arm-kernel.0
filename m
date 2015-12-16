From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Dec 2015 11:29:15 +0000
Subject: [RFC PATCH v3 4/8] arm64: Handle early CPU boot failures
In-Reply-To: <56713F76.8080907@arm.com>
References: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
 <1449655039-22022-5-git-send-email-suzuki.poulose@arm.com>
 <20151215115518.GE9452@arm.com> <56713F76.8080907@arm.com>
Message-ID: <20151216112914.GF4308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 10:39:50AM +0000, Suzuki K. Poulose wrote:
> On 15/12/15 11:55, Will Deacon wrote:
> >On Wed, Dec 09, 2015 at 09:57:15AM +0000, Suzuki K. Poulose wrote:
> 
> >>  /*
> >>   * Initial data for bringing up a secondary CPU.
> >>+ * @stack  - sp for the secondary CPU
> >>+ * @status - Result passed back from the secondary CPU to
> >>+ *           indicate failure.
> >>   */
> >>  struct secondary_data {
> >>  	void *stack;
> >>-};
> >>+	unsigned long status;
> >>+} ____cacheline_aligned;
> >
> >Why is this necessary?
> 
> That was based on a suggestion from Mark Rutland here:
> 
>   https://lkml.org/lkml/2015/12/1/580

That thread is talking about the CWG, which is not the same thing as
____cacheline_aligned. Given that the architectural maximum for the CWG
is 2K, we can probably get away with allocating the status field amongst
the head.S text instead (which we know will be clean).

Since SMP boot is serialised, that should be sufficient, right?

Will
