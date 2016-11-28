From: drjones@redhat.com (Andrew Jones)
Date: Mon, 28 Nov 2016 09:51:28 +0100
Subject: [kvm-unit-tests PATCH v7 01/11] run_tests: allow forcing of
 acceleration mode
In-Reply-To: <20161124161033.11456-2-alex.bennee@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
 <20161124161033.11456-2-alex.bennee@linaro.org>
Message-ID: <20161128085128.sqr7nmfc7hzugdis@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 04:10:23PM +0000, Alex Benn?e wrote:
> While tests can be pegged to tcg it is useful to override this from time
> to time, especially when testing correctness on real systems.
> ---
>  run_tests.sh         | 8 ++++++--
>  scripts/runtime.bash | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index 254129d..b88c36f 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -13,9 +13,10 @@ function usage()
>  {
>  cat <<EOF
>  
> -Usage: $0 [-g group] [-h] [-v]
> +Usage: $0 [-g group] [-a accel] [-h] [-v]
>  
>      -g: Only execute tests in the given group
> +    -a: Force acceleration mode (tcg/kvm)
>      -h: Output this help text
>      -v: Enables verbose mode
>  
> @@ -28,11 +29,14 @@ EOF
>  RUNTIME_arch_run="./$TEST_DIR/run"
>  source scripts/runtime.bash
>  
> -while getopts "g:hv" opt; do
> +while getopts "g:a:hv" opt; do
>      case $opt in
>          g)
>              only_group=$OPTARG
>              ;;
> +        a)
> +            force_accel=$OPTARG
> +            ;;
>          h)
>              usage
>              exit
> diff --git a/scripts/runtime.bash b/scripts/runtime.bash
> index 11a40a9..578cf32 100644
> --- a/scripts/runtime.bash
> +++ b/scripts/runtime.bash
> @@ -75,6 +75,10 @@ function run()
>          return;
>      fi
>  
> +    if [ -n "$force_accel" ]; then
> +        accel=$force_accel
> +    fi
> +
>      if [ -n "$arch" ] && [ "$arch" != "$ARCH" ]; then
>          echo "`SKIP` $1 ($arch only)"
>          return 2
> -- 
> 2.10.1

We can already do 'ACCEL=tcg ./run_tests.sh' to force, for example, tcg.
Additionally, you can add any env you want to the config.mak after running
configure,

 echo ACCEL=tcg >> config.mak

If you still prefer a cmdline parameter, then I'd suggest a boolean
instead, with the default being KVM. So the param would be '-tcg', or
something.

Thanks,
drew
