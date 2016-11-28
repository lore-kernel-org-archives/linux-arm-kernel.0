From: drjones@redhat.com (Andrew Jones)
Date: Mon, 28 Nov 2016 11:51:35 +0100
Subject: [Qemu-devel] [kvm-unit-tests PATCH v7 00/11] QEMU MTTCG Test cases
In-Reply-To: <20161124161033.11456-1-alex.bennee@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
Message-ID: <20161128105135.ryolphjeiho56hbm@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 04:10:22PM +0000, Alex Benn?e wrote:
> Hi,
> 
> Looking at my records it seems as though it has been a while since I
> last posted these tests. As I'm hoping to get the final bits of MTTCG
> merged upstream on the next QEMU development cycle I've been re-basing
> these and getting them cleaned up for merging.
> 
> Some of the patches might be worth taking now if the maintainers are
> happy to do so (run_test tweaks, libcflat updates?). The others could
> do with more serious review. I've CC'd some of the ARM guys to look
> over the tlbflush/barrier tests so they can cast their expert eyes
> over them ;-)
> 
> There are two additions to the series.
> 
> The tcg-test is a general torture test aimed at QEMU's TCG execution
> model. It stresses the cpu execution loop through the use of
> cross-page and computed jumps. It can also add IRQ's and self-modifying
> code to the mix.
> 
> The tlbflush-data test is a new one, the old tlbflush test is renamed
> tlbflush-code to better indicate the code path it exercise. The the
> code test tests the translation invalidation pathways in QEMU the data
> test exercises the SoftMMU's TLBs and explicitly that tlbflush
> completion semantics are correct.
> 
> The tlbflush-data passes most of the times on real hardware but
> definitely showed the problem with deferred TLB flushes running under
> MTTCG QEMU. I've looked at some of the failure cases on real hardware
> and it did look like a timestamp appeared on a page that shouldn't
> have been accessible at the time - I don't know if this is a real
> silicon bug or my misreading of the semantics so I'd appreciate
> a comment from the experts.

One other thought. I'm not sure how best to approach a bunch of TCG-only
tests getting integrated. I'm thinking it might be nice to give them
their own subdir under the arch dir, e.g. arm/tcg. That subdir would
have its own unittests.cfg file too. Otherwise when we run on KVM we'll
have a load of "SKIP: requires TCG" type messages...

We'll want to add a run_tests.sh option to pass the name of the subdir,
'-d tcg'. When the subdir name is 'tcg' ACCEL could automatically be
switched to 'tcg' as well.

Thanks,
drew
