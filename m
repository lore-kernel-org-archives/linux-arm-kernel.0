From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Oct 2017 14:35:30 +0100
Subject: [RFC 2/3] perf tool: stat: say more about why event is not
 supported by the kernel
In-Reply-To: <20171024030408.d29c81d6134bf63df18ae618@arm.com>
References: <20171024030408.d29c81d6134bf63df18ae618@arm.com>
Message-ID: <20171024133530.GB13445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 03:04:08AM -0500, Kim Phillips wrote:
> Call perf_evsel__open_strerror() to potentially expand upon why the
> event was "not supported by the kernel."  See the enhanced '-v' example
> output messages in the next patch.

Nit: it would be better if the commit message was self-contained. It might
also be worth moving some of the commit meesage for the final patch out into
a cover letter, since there's an awful lot in there.

> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  tools/perf/builtin-stat.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 69523ed55894..8f0323db3c00 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -625,9 +625,13 @@ static int __run_perf_stat(int argc, const char **argv)
>  			if (errno == EINVAL || errno == ENOSYS ||
>  			    errno == ENOENT || errno == EOPNOTSUPP ||
>  			    errno == ENXIO) {
> -				if (verbose > 0)
> +				if (verbose > 0) {
>  					ui__warning("%s event is not supported by the kernel.\n",
>  						    perf_evsel__name(counter));
> +					perf_evsel__open_strerror(counter, &target,
> +								  errno, msg, sizeof(msg));
> +					ui__error("%s\n", msg);
> +				}

Hmm, perf_evsel__open_strerror can already get called a few lines later, so
I don't think this change is right. It looks like the intention here is that
we can push ahead skipping unsupported events unless they are the leader of
a populated group. If this isn't working as intended, then it looks like we
need a helper to identify unsupported events instead.

Will
