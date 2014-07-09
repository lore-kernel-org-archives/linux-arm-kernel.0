From: riel@redhat.com (Rik van Riel)
Date: Tue, 08 Jul 2014 23:05:20 -0400
Subject: [PATCH v3 01/12] sched: fix imbalance flag reset
In-Reply-To: <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
Message-ID: <53BCB170.9020005@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/30/2014 12:05 PM, Vincent Guittot wrote:
> The imbalance flag can stay set whereas there is no imbalance.
> 
> Let assume that we have 3 tasks that run on a dual cores /dual
> cluster system. We will have some idle load balance which are
> triggered during tick. Unfortunately, the tick is also used to
> queue background work so we can reach the situation where short
> work has been queued on a CPU which already runs a task. The load
> balance will detect this imbalance (2 tasks on 1 CPU and an idle 
> CPU) and will try to pull the waiting task on the idle CPU. The
> waiting task is a worker thread that is pinned on a CPU so an
> imbalance due to pinned task is detected and the imbalance flag is
> set. Then, we will not be able to clear the flag because we have at
> most 1 task on each CPU but the imbalance flag will trig to useless
> active load balance between the idle CPU and the busy CPU.
> 
> We need to reset of the imbalance flag as soon as we have reached a
> balanced state.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rik van Riel <riel@redhat.com>


- -- 
All rights reversed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTvLFvAAoJEM553pKExN6DUcYIAJkj0fl4DIpx/7ywqSSCo4Da
1IpJI5Hz2zb+NunG8M/4kugDSYvMmiuNhFgG1ET7me11jxTcTqg0e8UZ4zJbW55u
i14IVyXLW+AVhJNQc1Umu3c6tTnjawOIzLa4wJ5JCVFVTj/5AhHyJjbKfQJnew1q
XlYm8+FPGmXQgJ0G3itmpx3gAYsrQIQXtIhM9wwgmKiysF4s+HZZppyZKtGbOtm4
ia408LsmjOYYp4vGSTa4F4IWx1K0fJVpz33TsCLb2pwKy6t/4hKf9tOn/wXPSLVc
NbWrP7zYYJ8EaXgo/RV9OJnPXq0h0Tbp9eMtd4u/hRCrcHw1dUZBpDMIRkS5NzI=
=uoh0
-----END PGP SIGNATURE-----
