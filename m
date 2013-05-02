From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Thu, 2 May 2013 11:46:13 -0400
Subject: [PATCH, RFC 12/22] thermal: cpu_cooling: fix stub function
In-Reply-To: <1367507786-505303-13-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-13-git-send-email-arnd@arndb.de>
Message-ID: <51828A45.60909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-05-2013 11:16, Arnd Bergmann wrote:
> The function stub for cpufreq_cooling_get_level introduced
> in 57df81069 "Thermal: exynos: fix cooling state translation"
> is not syntactically correct C and needs to be fixed to avoid
> this error:
> 
> In file included from drivers/thermal/db8500_thermal.c:20:0:
>  include/linux/cpu_cooling.h: In function 'cpufreq_cooling_get_level':
> include/linux/cpu_cooling.h:57:1:
>  error: parameter name omitted  unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int)  ^
>  include/linux/cpu_cooling.h:57:1: error: parameter name omitted
> 
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Amit Daniel kachhap <amit.daniel@samsung.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/cpu_cooling.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 282e270..cf03111 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -54,7 +54,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  	return;
>  }
>  static inline
> -unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int)
> +unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)

While there, could you please also include the following (same, but on
the function declaration on line 44), just to keep the header in same style?
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 282e270..c023afa 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -41,7 +41,7 @@ cpufreq_cooling_register(const struct cpumask *clip_cpus);
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);

-unsigned long cpufreq_cooling_get_level(unsigned int, unsigned int);
+unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int
freq);
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(const struct cpumask *clip_cpus)


>  {
>  	return THERMAL_CSTATE_INVALID;
>  }
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130502/91dc8c11/attachment.sig>
