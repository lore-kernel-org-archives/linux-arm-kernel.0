From: acme@infradead.org (Arnaldo Carvalho de Melo)
Date: Fri, 22 Jan 2010 10:26:07 -0200
Subject: [PATCH v1 1/1] Extended events (platform-specific) support in perf
In-Reply-To: <1264162139-26788-2-git-send-email-t.fujak@samsung.com>
References: <1264162139-26788-1-git-send-email-t.fujak@samsung.com>
	<1264162139-26788-2-git-send-email-t.fujak@samsung.com>
Message-ID: <20100122122607.GE1244@ghostprotocols.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Jan 22, 2010 at 01:08:59PM +0100, Tomasz Fujak escreveu:
> Signed-off-by: Tomasz Fujak <t.fujak@samsung.com>
> Reviewed-by: Pawel Osciak <p.osciak@samsung.com>
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kuyngmin.park@samsung.com>

"Extended" seems vague, I think in this context "platform_" would be a
better namespace specifier.
 
> ---
>  tools/perf/util/parse-events.c |  224 ++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 213 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 05d0c5c..3e32198 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -9,6 +9,9 @@
>  #include "header.h"
>  #include "debugfs.h"
>  
> +#define			EXTENDED_EVENT_PATH	\
> +			"/sys/devices/system/cpu/perf_events/extevents"
> +
>  int				nr_counters;
>  
>  struct perf_event_attr		attrs[MAX_COUNTERS];
> @@ -60,6 +63,10 @@ static struct event_symbol event_symbols[] = {
>  #define PERF_EVENT_TYPE(config)	__PERF_EVENT_FIELD(config, TYPE)
>  #define PERF_EVENT_ID(config)		__PERF_EVENT_FIELD(config, EVENT)
>  
> +static struct event_symbol *extended_event_symbols;
> +static unsigned int 	extended_event_count;
> +static int 			extended_events_initialized;
> +
>  static const char *hw_event_names[] = {
>  	"cycles",
>  	"instructions",
> @@ -241,6 +248,157 @@ static const char *tracepoint_id_to_name(u64 config)
>  	return buf;
>  }
>  
> +static unsigned count_lines(const char *str, unsigned size)
> +{
> +	unsigned count = 0;
> +
> +	while (size--)
> +		count += ('\n' == *str++);
> +	return count;
> +}
> +
> +#define	BYTES_PER_CHUNK 4096
> +/* returns the number of lines read;
> +   on fail the return is negative and no memory is allocated
> +   otherwise the *buf contains a memory chunk of which first
> +   *size bytes are used for file contents
> + */
> +static int read_file(int fd, char **buf, unsigned *size)
> +{
> +	unsigned bytes = BYTES_PER_CHUNK;
> +	int lines = 0;
> +	char *ptr = malloc(bytes);

malloc can fail... Also why is that you can't process the lines one by
one instead of reading the whole (albeit small) file at once?

> +	*size = 0;
> +	do {
> +		int ret = read(fd, ptr + *size, bytes - *size);
> +		if (ret < 0) {
> +			if (EINTR == errno)
> +				continue;
> +			else {
> +				free(ptr);
> +				return -1;
> +			}
> +		}
> +
> +		if (!ret)
> +			break;
> +
> +		lines += count_lines(ptr + *size, ret);
> +		*size += ret;
> +
> +		if (*size == bytes) {
> +			char *tmp = realloc(ptr, bytes <<= 1);
> +			if (!tmp) {
> +				free(ptr);
> +				return -1;
> +			}
> +			ptr = tmp;
> +		}
> +	} while (1);
> +
> +	*buf = ptr;
> +	return lines;
> +}
> +
> +static int parse_extevent_file(struct event_symbol *symbols,
> +			unsigned lines, char *buf)
> +{
> +	char *name, *description, *ptr, *end;
> +	unsigned offset = 0, count = 0;
> +	int items, eaten;
> +	unsigned long long discard;
> +
> +/* each line format should be "0x%llx\t%s\t%lld-%lld\t%s\n" */
> +	while (lines--) {
> +		items = sscanf(buf + offset + 2, "%llx",
> +				&symbols[count].config);
> +		if (1 != items)
> +			continue;
> +
> +		/* skip 0x%llx\t */
> +		ptr = strchr(buf + offset, '\t') + 1;
> +
> +		name = description = NULL;
> +
> +		end = strchr(ptr, '\t');
> +		if (end) {
> +			name = strndup(ptr, end - ptr);
> +			ptr = end + 1;
> +		}
> +
> +		ptr = end;
> +		items = sscanf(ptr, "%lld-%lld\t%n", &discard, &discard,
> +			 &eaten);
> +		if (2 != items)
> +			continue;
> +
> +		ptr += eaten;
> +		end = strchr(ptr, '\n');
> +		if (end) {
> +			description = strndup(ptr, end - ptr);
> +			offset = end - buf + 1;
> +		} else
> +			break;
> +
> +		if (name && description) {
> +			symbols[count].symbol = name;
> +			symbols[count].alias = "";
> +			++count;
> +			/* description gets lost here */
> +			free(description);
> +		} else {
> +			free(description);
> +			free(name);
> +		}

Having "free(description);" in both cases seems funny :-)

- Arnaldo
