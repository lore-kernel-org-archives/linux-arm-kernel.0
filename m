From: riel@redhat.com (Rik van Riel)
Date: Tue, 08 Jul 2014 23:36:26 -0400
Subject: [PATCH v3 01/12] sched: fix imbalance flag reset
In-Reply-To: <53BCB170.9020005@redhat.com>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-2-git-send-email-vincent.guittot@linaro.org>
 <53BCB170.9020005@redhat.com>
Message-ID: <53BCB8BA.3070904@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/08/2014 11:05 PM, Rik van Riel wrote:
> On 06/30/2014 12:05 PM, Vincent Guittot wrote:
>> The imbalance flag can stay set whereas there is no imbalance.
> 
>> Let assume that we have 3 tasks that run on a dual cores /dual 
>> cluster system. We will have some idle load balance which are 
>> triggered during tick. Unfortunately, the tick is also used to 
>> queue background work so we can reach the situation where short 
>> work has been queued on a CPU which already runs a task. The
>> load balance will detect this imbalance (2 tasks on 1 CPU and an
>> idle CPU) and will try to pull the waiting task on the idle CPU.
>> The waiting task is a worker thread that is pinned on a CPU so
>> an imbalance due to pinned task is detected and the imbalance
>> flag is set. Then, we will not be able to clear the flag because
>> we have at most 1 task on each CPU but the imbalance flag will
>> trig to useless active load balance between the idle CPU and the
>> busy CPU.
> 
>> We need to reset of the imbalance flag as soon as we have reached
>> a balanced state.
> 
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Acked-by: Rik van Riel <riel@redhat.com>

Never mind that, Preeti explained the failure mode in more detail
on irc, and I am no longer convinced this change is a good idea.

- -- 
All rights reversed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTvLi6AAoJEM553pKExN6DEAUH/A+dwZ4MYW1JafoKN3iaFzgr
FqUzDayZ5NO2fSKNoa35CqvPhyZzAjeQn4H2yh0u/EhNI+1MzIqMY4i8l6dmB3QO
woOj8pf6O5lB1+iWk9F2moEJRX2y3X8mhhysO3ujR8211Ic7t12Z195+SH7qD2OD
xDjmRd/hTyNtn8mHOpcC2A69jaac8ZHKL6zNJcE9ax0IQxLTxZ+BzQnJhCtILEbD
a2eYe/Dm039bvgZjIRmy0ht+GkTtUuA6Yn7/SxLbQMQ0eSolan0DC3M7TSB3SkDB
z6lczf4lrMbyJdPhq1MX+C9YfbUAsICE2XQZYhpn/nopem0MTKBfQoLG4W3fWOg=
=6eQR
-----END PGP SIGNATURE-----
